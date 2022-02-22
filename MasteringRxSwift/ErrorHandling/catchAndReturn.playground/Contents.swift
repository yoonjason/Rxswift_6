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
 # catchAndReturn
 */
/**
 옵져버블 대신 기본값을 전달하는
 
 */
let bag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()

subject
    .catchAndReturn(-1) //subjcet가 방출하는 형식이 Int이기 때문이다.
    .subscribe { print($0) }
    .disposed(by: bag)

subject.onError(MyError.error) //파라미터로 전달된 값이 구독자에게 전달된다. 그냥 하나의 값이다.
/**
 에러가 발생했을 때 기본 값이 있다면,catchAndReturn을 사용한다. 에러의 종류와 관계 없이 항상 동일한 값만 내뱉는다.(단점)
 나머지 경우에는 catch를 사용한다. 클로져를 통해 에러처리 코드를 자유롭게 구현할 수 있다는 장점이 있다.
 
 작업을 처음부터 새롭게 시작하고 싶다면 retry연산자를 사용한다.
 
 
 */
