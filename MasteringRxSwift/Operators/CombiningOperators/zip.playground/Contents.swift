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
 # zip
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let numbers = PublishSubject<Int>()
let strings = PublishSubject<String>()


/**
 combineLatest와 비교해보면 쉽게 이해된다.
 클로저에게 중복된 인덱스를 전달하지않는다.
 첫번째 요소는 첫번째 요소와 결합
 두번째 요소는 두번째 요소와 결합
 
 
 1-------2---------------3---4----5
 ----A-------B-----C---D-----------
 
 -----1A-------2B---------3C---4D---
 
 indexed Sequencing
 */
Observable.zip(numbers, strings) { "\($0) - \($1)" }
    .subscribe {
    print($0)
}
    .disposed(by: bag)

numbers.onNext(1)
strings.onNext("one")

numbers.onNext(2) //strings에서 새로운 문자열을 방출할 때까지 대기한다.
strings.onNext("two")

//numbers.onCompleted()
numbers.onError(MyError.error)
strings.onNext("three")

strings.onCompleted() //합쳐진 요소들이 다 onCompleted가 전달되어야 구독자에게도 completed가 전달된다.



