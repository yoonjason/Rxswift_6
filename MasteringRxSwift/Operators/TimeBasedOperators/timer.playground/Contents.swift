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
 # timer
 */
/**
 
정수를 반복적으로 방출하는 옵져버블 생성
 지연시간과 조절할 수 있다.
 dueTime: 구독을 시작하고 첫번째 요소가 구독자에게 전달되는 상대적인 시간, 1초를 적으면 1초후에 구독자에게 전달
 period: 반복주기, 반복주기가 없으면 하나의 요소만 방출하고 종료된다.
 
 */
let bag = DisposeBag()

//Observable<Int>.timer(.seconds(1), scheduler: MainScheduler.instance)
//    .subscribe{ print($0) }
//    .disposed(by: bag)

let i = Observable<Int>.timer(.seconds(1), period: .milliseconds(500), scheduler: MainScheduler.instance) //반복주기 0.5초
    .subscribe{ print($0) }


DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    i.dispose()
}








