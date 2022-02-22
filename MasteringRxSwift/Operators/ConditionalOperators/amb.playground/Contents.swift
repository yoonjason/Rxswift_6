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
 # amb
 */
/**
 두개 이상의 소스 옵져버블에서 ~ 제일 먼저 방출되는 옵져버블이 전달되고, 나머지는 무시된다.
 여러 서버로 데이터들 전달하고 가장 빨리 전달하는 패턴을 구현할 수잇다.
 
 세개이상의 옵져버블을 사용해야한다면, 타입메서드의 메서드를 이용하며 배열로 전달해야한다.
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()
let c = PublishSubject<String>()

//a
//    .amb(b)
//    .subscribe { print($0) }
//    .disposed(by: bag)
//
//
//a.onNext("A")
//b.onNext("B") //a가 먼저 방출되어 b는 무시한다.
//
//b.onCompleted() //completed는 무시된다.
//a.onCompleted()



Observable.amb([a, b, c])
    .subscribe { print($0) }
    .disposed(by: bag)

b.onNext("B") //가장 먼저 방출된 것만 전달되고, 나머진 무시한다.
c.onNext("C")
a.onNext("A")


