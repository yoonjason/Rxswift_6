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
 # retry
 */
/**
 소스 옵져버블에서 에러가 발생하면 옵져버블에 대한 구독을 해제하고, 새로운 구독을 한다.
 옵져버블의 작업은 처음부터 다시 시작하게된다.
 에러가 발생하지 않으면 정상적으로 종료, 에러가 발생하면 다시 새로운 구독을 시작한다.
 
 파라미터 없이 호출하면 옵져버블이 정상적으로 완료될 때까지 계속해서 재시도, 재시도 횟수가 늘어남에 따라 리소스를 낭비할 수 있다. 터치 이벤트를 처리할 수 없거나, 앱이 죽는 경우도 발생
 maxAttemptCount: 재시도 횟수를 전달한다. 항상 1을 더해서 전달해야한다.
 */
let bag = DisposeBag()

enum MyError: Error {
    case error
}

var attempts = 1

let source = Observable<Int>.create { observer in
    let currentAttempts = attempts
    print("#\(currentAttempts) START")
    
    if attempts < 3 {
        observer.onError(MyError.error)
        attempts += 1
    }
    
    observer.onNext(1)
    observer.onNext(2)
    observer.onCompleted()
    
    return Disposables.create {
        print("#\(currentAttempts) END")
    }
}

source
    .retry(7) //마지막 결과역시 에러라면 에러를 뿜는다.
    .subscribe { print($0) }
    .disposed(by: bag)

//재시도 횟수를 전달할 때는 항상 1을 더해야한다. 7을 제공했기 때문에 6번 재시도 했다.
//재시도 시점을 제어하는 것은 불가능하다. 사용자가 재시도를 탭하는 경우에만 하고 싶다면, retryWhen연산자를 사용한다.
