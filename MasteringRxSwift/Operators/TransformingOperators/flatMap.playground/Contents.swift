//
//  Mastering RxSwift
//  Copyright (c) KxCoding <help@kxcoding.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # flatMap
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redRectangle = "🟥"
let greenRectangle = "🟩"
let blueRectangle = "🟦"

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject
    .flatMap {
    $0.asObservable()
}
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(a)

subject.onNext(b)

a.onNext(11)

b.onNext(22)

//새로운 옵져버블은 항목이 업데이트될때 마다 새로운 옵져버블을 방출한다. 모든 항목들이 이 옵져버블들을 이용해서 전달된다. 업데이트된 최신 항목도 구독자로 전달된다.
//네트워크 요청을 구현할 때 사용된다.
//최종적으로 하나의 옵져버블을 통해서 구독자로 전달된다.

let circle = BehaviorSubject<String>(value: "")
let rectangle = BehaviorSubject<String>(value: "")

let subject1 = PublishSubject<BehaviorSubject<String>>()

//subject1
//    .flatMap { $0.asObservable() }
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)
//
//subject1.onNext(circle)
//subject1.onNext(rectangle)
//
//circle.onNext(redCircle)
//rectangle.onNext(redRectangle)


Observable.from([redCircle, greenCircle, blueCircle])
    .flatMap { circle -> Observable<String> in
    switch circle {
    case redCircle:
        return Observable.repeatElement(redRectangle)
            .take(5)
    case greenCircle:
        return Observable.repeatElement(greenRectangle)
            .take(5)
    case blueCircle:
        return Observable.repeatElement(blueRectangle)
            .take(5)
    default:
        return Observable.just("")
    }
}
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)

//리절트 옵져버블을 통해서 지연없이 방출된다. 먼저 방출되는 경우도 있다. interLeaving
//conactmap은 인터리빙이 허용되지않는다.

