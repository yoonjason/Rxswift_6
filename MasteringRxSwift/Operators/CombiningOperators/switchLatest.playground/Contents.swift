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
 # switchLatest
 */
/**
 가장 최근 옵져버블이 방출하는 이벤트를 구독자에게 전달한다.
 어떤게 가장 최근인지 이해하는게 핵심
 
 
 */
let bag = DisposeBag()

enum MyError: Error {
    case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()


let source = PublishSubject<Observable<String>>()//문자열을 방출하는 옵져버블을 방출하는 subject이다.

source
    .switchLatest()
    .subscribe { print($0) }
    .disposed(by: bag)

a.onNext("1")
b.onNext("a")

source.onNext(b)

a.onNext("2")
b.onNext("b")

source.onNext(a)

a.onNext("3")
b.onNext("c")

source.onNext(b)

a.onNext("4")
b.onNext("d")

source.onNext(a)

a.onNext("5")
b.onNext("e")

/**
 source에 옵져버블 next 이벤트를 전달하고, 그 다음 해당 옵져버블에서 값이 next이벤트로 전달되어야 값이 넘어온다.
다시 다른 옵져버블로 next이벤트를 전달하면, 이전 해당 옵져버블은 구독을 중단한다. 값은 머물러있다.
 
 
 */
//a.onNext("1")
//b.onNext("b")
//
//source.onNext(a) //옵져버블이 방출된다.
//
//a.onNext("2") //새로운 넥스트 이벤트를 구현하면 즉시 방출된다.
//b.onNext("b")
//
//source.onNext(b) //b가 최신 옵져버블
////source.onNext(a)
//
//a.onNext("3")
//b.onNext("c")
//
//source.onNext(a)
//
////a.onCompleted()
////b.onCompleted()
//
////source.onCompleted()
//
//a.onError(MyError.error)
//b.onError(MyError.error)
