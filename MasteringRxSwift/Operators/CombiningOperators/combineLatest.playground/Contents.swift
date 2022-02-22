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
 # combineLatest
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let greetings = PublishSubject<String>() //source Observable
let languages = PublishSubject<String>() //source Observable

//source Observable을 결합한다음 연산자가 리턴한 옵져버블이 언제 옵져버블을 방출하는지 이해하는게 핵심이다.

Observable.combineLatest(greetings, languages) { lhs, rhs -> String in
    return "\(lhs), \(rhs)"
}
.subscribe {
print($0)
}
.disposed(by: bag)

greetings.onNext("Hello")
languages.onNext("world") // 입력된 소스 옵져버블이 모두 이벤트를 받아야 보인다. Behavior로 하게되면 초기값이 있기때문에 다를 수 있다.

greetings.onNext("hi!")
languages.onNext("Swift")

//greetings.onCompleted()
greetings.onError(MyError.error)
languages.onNext("SwitUI") //에러일 경우 다음건 전달 안된다.

languages.onCompleted()

