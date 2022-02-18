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
 # generate
 */
/**
 initialState: 시작 값을 전달한다. 가장 먼저 방출되는 값을 전달한다.
 condition: true 리턴하는 경우에만 요소가 방출된다. false를 리턴하면 completed이벤트 방출
 iterate : 값을 바꾸는 코드 전달, 증가 시키거나 감소시키는 코드 전달
 
 파라미터 형식이 정수로 제한되지 않는다.
 */


let disposeBag = DisposeBag()
let red = "🔴"
let blue = "🔵"


Observable.generate(initialState: 0) {
    $0 <= 10
} iterate: {
    $0 + 2
}
.subscribe(onNext:{
    print("first == \($0)")
})
.disposed(by: disposeBag)

Observable.generate(initialState: 10) {
    $0 >= 10
} iterate: {
    $0 - 2
}
.subscribe{
    print("second == \($0)")
}
.disposed(by: disposeBag)



Observable.generate(initialState: red) {
    $0.count < 15
} iterate: {
    $0.count.isMultiple(of: 2) ? $0 + red : $0 + blue
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)


