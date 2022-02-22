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
 # withLatestFrom
 */
/**
 연산자를 호출하는 옵져버블을 트리거 옵져버블
 파라미터로 전달하는 옵져버블을 데이터 옵져버블
 
 트리거 옵져버블을 가장 최근에 방출한 이벤트를 전달한다.
 
 
 회원가입 버튼을 탭하는 시점에 텍스트 필드에 입력된 값을 가져오는 기능을 구현할 때 활용할 수 있다.
 
 */
let bag = DisposeBag()

enum MyError: Error {
    case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

trigger.withLatestFrom(data)
    .subscribe {
    print($0)
}
    .disposed(by: bag)

data.onNext("Hello")
trigger.onNext(()) //트리거로 넥스트 이벤트를 전달하면 data에 전달된 next이벤트가 구독자에게 전달된다.
trigger.onNext(())
data.onNext("Swift")

trigger.onNext(()) //트리거가 넥스트 이벤트가 전달이 되어야만 직전에 호출되는게 전달된다.

//data.onCompleted()
//data.onError(MyError.error)
//trigger.onNext(())

trigger.onCompleted()
