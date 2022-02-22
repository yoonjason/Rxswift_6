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
 # merge
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)

//여러 옵져버블에서 방출하는 이벤트를 하나의 옵져버블에서 방출한다.
//두개 이상의 옵져버블을 병합하고 모든 옵져버블에서 방출하는 요소들을 순서대로 방출한다.

let source = Observable.of(oddNumbers, evenNumbers, negativeNumbers)

source
    .merge(maxConcurrent: 2) //maxConcurrent를 사용할 경우 negativeNumbers는 머지되지 않는다.
    .subscribe{ print($0) }
.disposed(by: bag)

//컨캣처럼 뒤에 이어지는 것이 아닌 하나의 옵져버블을 만들어준다.

oddNumbers.onNext(3)
evenNumbers.onNext(4)

evenNumbers.onNext(6)
oddNumbers.onNext(5)

//oddNumbers.onCompleted()
//oddNumbers.onError(MyError.error) //에러면 바로 에러를 내면서 이전까지의 요소를 전달한다.

evenNumbers.onNext(7)
oddNumbers.onNext(8)

negativeNumbers.onNext(-2)
negativeNumbers.onNext(-3)

evenNumbers.onCompleted() //evenNumbers가 컴플리트되고나면 negativeNumbers가 머지 순서에 합류한다.



