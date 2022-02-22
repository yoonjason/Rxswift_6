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
 # timeout
 */
/**
 정수ㅡㄹ 방출하는 서브젝트 선언
 타임아웃 연산자 호출하고 구독
 
소스옵져버블이 방출하는 모든요소에 타임아웃을 지정한다.
 dueTime:시간안에 방출하지않으면 error를 방출한다.
 시간안에 방출하면, 구독자에게 전달한다.
 other: 옵져버블 전달
 */

let bag = DisposeBag()

let subject = PublishSubject<Int>()

//subject.timeout(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe { print($0) }
//    .disposed(by: bag)

Observable<Int>.timer(.seconds(2), period: .seconds(5), scheduler: MainScheduler.instance)
    .subscribe(onNext: {
    subject.onNext($0)
})
    .disposed(by: bag)
//다음에 값이 전달되는 시간이 5초


subject.timeout(.seconds(3), other: Observable.just(1), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: bag)
/**
 next(0)
 next(1)
 completed
 
타임아웃이 전달되면, other에 선언되어있는 옵져버블이 전달된다.
 */


