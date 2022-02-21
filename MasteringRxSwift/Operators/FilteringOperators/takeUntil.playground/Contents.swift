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
 # take(until:)
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject.take(until: trigger)
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)

//trigger.onNext(0)

subject.onNext(3)

//파라미터로 방출한 옵져버블이 원본 옵져버블이 방출하는 이벤트를 그대로 전달한다.

let subject1 = PublishSubject<Int>()
subject1.take(until: { $0 > 5 })
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)

subject1.onNext(1)
subject1.onNext(2)
subject1.onNext(9)

//true를 방출하면 옵져버블을 중단하고 false일 때 방출한다.








