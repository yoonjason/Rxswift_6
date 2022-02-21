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
 # distinctUntilChanged
 */

struct Person {
    let name: String
    let age: Int
}

let disposeBag = DisposeBag()
let numbers = [1, 1, 3, 2, 2, 3, 1, 5, 5, 7, 7, 7]
let tuples = [(1, "하나"), (1, "일"), (1, "one")]
let persons = [
    Person(name: "Sam", age: 12),
    Person(name: "Paul", age: 12),
    Person(name: "Tim", age: 56)
]

Observable.from(numbers)
    .distinctUntilChanged() //두번째로 방출되는 이벤트를 무시한다. 동일한 이벤트가 연속적으로 방출되는 지만 확인한다.
.subscribe { print($0) }
    .disposed(by: disposeBag)

//이벤트를 비교할 때 이벤트에 포함된 동일성을 비교한다.

Observable.from(numbers)
    .distinctUntilChanged({
    !$0.isMultiple(of: 2) && !$1.isMultiple(of: 2)
})
    .subscribe { print($0) }
    .disposed(by: disposeBag)

Observable.from(tuples)
    .distinctUntilChanged {
    $0.1 //값이 다르므로 방출된다.
}
    .subscribe {
    print($0)
}
    .disposed(by: disposeBag)

Observable.from(persons)
    .distinctUntilChanged(at: \.name)
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)
