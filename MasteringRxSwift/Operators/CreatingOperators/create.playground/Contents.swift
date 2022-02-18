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
 # create
 */
/**
 
 앞에서 배운 연산자들은 파라미터로 전달된 요소를 방출하는 옵져버블을 생성한다.
 모든 요소를 방출하고 컴플리티드 방출 후 종료
 동작을 바꿀 수는 없다.
 
 옵져버블이 동작하는 방식을 직접 구현하고 싶다면 create 연산자를 사용한다.
 
 */
let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

/**
 
 url html을 다운로드 한 다음에문자열을 방출하는 옵져버블 구현
 옵져버블을 파라미터로 받아서 Disposable을 리턴하는 클로져를 전달한다.
 리턴형이 Disposable 이어서 Disposable.create()를 하는 경우가 있는데 Disposables.create()로 호출해야한다/
 */

Observable<String>.create { (observer) -> Disposable in
    guard let url = URL(string: "https://www.apple.com") else {
        observer.onError(MyError.error)
        return Disposables.create()
    }
    guard let html = try? String(contentsOf: url, encoding: .utf8) else {
        observer.onError(MyError.error)
        return Disposables.create()
    }

    observer.onNext(html)
    observer.onCompleted()
    
    observer.onNext("After Completed")
    return Disposables.create()
}
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

/**
 코드를 보면
 에러가 발생하면 에러 이벤트를 전달하고 종료한다.
 문자열을 정상적으로 가져왔다면, 여기에서 문자열을 방출한다.
 
 */


/**
 옵져버블은 completed나 error 후에는 방출되지않는다.
 
 기본적인 규칙
 요소를 방출할 때는 onNext를 사용해서 파라미터로 방출할 요소를 전달한다.
 옵져버블은 보통 하나 이상의 요소를 방출하지만, 그렇지 않은 경우도 있다.
 그래서 반드시 onNext를 호출해야하는 것은 아니다.
 옵져버블을 종료하기 위해서는 onError, onCompleted를 반드시 호출해야한다.
 옵져버블 중에는 영원히 종료되지않는 것이 있는데, 반드시 호출해야한다.
 */











