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
 # retry(when:)
 */


let bag = DisposeBag()

enum MyError: Error {
    case error
}

var attempts = 1

let source = Observable<Int>.create { observer in
    let currentAttempts = attempts
    print("START #\(currentAttempts)")

    if attempts < 3 {
        observer.onError(MyError.error)
        attempts += 1
    }

    observer.onNext(1)
    observer.onNext(2)
    observer.onCompleted()

    return Disposables.create {
        print("END #\(currentAttempts)")
    }
}

let trigger = PublishSubject<Void>()
//클로져를 파라미터로 받는다, 옵져버블이 방출된다. 트리거 옵져버블을 리턴한다. 작업을 재시도 한다.
source
    .retry { _ in trigger }
    .subscribe { print($0) }
    .disposed(by: bag)

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    trigger.onNext(())
}



