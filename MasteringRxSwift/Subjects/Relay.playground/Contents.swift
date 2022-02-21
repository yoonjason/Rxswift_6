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
import RxCocoa

/**
 completed와 error은 받지않고. UI에서 활용한다.
 RxCocoa
 
 */
/*:
 # Relay
 */

let bag = DisposeBag()

let prelay = PublishRelay<Int>()

prelay.subscribe{print("1:\($0)")}
.disposed(by: bag)

prelay.accept(1)

let brelay = BehaviorRelay(value: 1)
brelay.accept(2)

brelay.subscribe{ print("2: \($0)")}
.disposed(by: bag)

brelay.accept(3)

print(brelay.value)

//Error 발생
// brelay.value = 4


//처음 버퍼의 크기를 전달한다.
let rrelay = ReplayRelay<Int>.create(bufferSize: 3)

(1...10).forEach { rrelay.accept($0) } //마지막 값3개만 전달

rrelay.subscribe{
    print("4: \($0)")
}
.disposed(by: bag)

