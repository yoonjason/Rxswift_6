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
 # catch(_:)
 */
/**
 옵져버블이 네트워크 처리를 하고, UI를 업데이트 하는 패턴을 생각해보자.
 에러이벤트가 전달되면 구도기 종료되고 더이상 next이벤트가 전달되지않는다. UI업데이트하는 코드는 실행되지 않는다.
 
 1. 에러이벤트가 전달되면 새로운 옵져버블을 리턴한다. catch연산자를 이용한다. next, completed는 구독자에게 그대로 전달, 옵져버블이 에러 이벤트를 방출하면 error 새로운 옵져버블을 만들어 전달
 서버에 접속할 수 없거나, url이 잘못 되었다면 구독자에게 에러이벤트가 전달된다.에러이벤트가 그대로 전달되면 ui가 업데이트 되지않아 앱을 사용할 수 없다.
 catch 연산자를 이용해서 옵져버블로 바꿔서 전달하고 옵져버블에서 기본 값이나 로컬 캐쉬를 방출하도록 구현하면 이런 문제는 해결된다.
 
 2.에러가 발생하면 옵져버블을 다시 구독한다. retry를 이용
 에러가 발생하지 않을 때까지 무한정 재시도 하거나, 재시도 횟수를 제한하는 방법을 사용한다.
 
 */

/**
 catch연산자와 에러 처리 패턴에 대해 보자.
 
 네트워크 요청 코드에서 자주 사용한다.
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()
let recovery = PublishSubject<Int>()

subject
    .catch { _ in recovery } //클로져를 파라미터로 받는다.  새로운 옵져버블을 리턴한다. 이 옵져버블은 소스 옵져버블과 동일한 값의 옵져버블을 방출한다.
.subscribe { print($0) }
    .disposed(by: bag)


subject.onError(MyError.error) //지금은 구독자에게 그대로 전달하며 구독이 종료된다.
subject.onNext(1234) //  새로운 next이벤트를 보내도 더 이상 전달되지 않는다.

//catch연산자가 리커버리 옵져버블로 교체했기 때문이다. 값자체는 구독자에게 전달된다.
recovery.onNext(232)

//recovery는 이상없이 전달되며, oncompleted는 에러 없이 정상적으로 종료된다.

//소스 옵져버블이 새로운 옵져버블로 교체하는 방식으로 진행한다.
