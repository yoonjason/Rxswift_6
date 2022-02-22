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
 # reduce
 */
/**
 scan과 비교
 1에서 5까지의 합
 
 */
let bag = DisposeBag()

enum MyError: Error {
    case error
}

let o = Observable.range(start: 1, count: 5)

print("== scan")

o.scan(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: bag) //더한 값을 다시 파라미터로 들어가게된다. 값이 계속 더해진다고 보면됨 +=
//작업의 결과를 누적시키면서 중간결과와 최종결과가 모두 필요한 경우에 사용한다.

print("== reduce")

o.reduce(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: bag)
//최종 값만 알수 있군요? 값이 다시 전달되지만, 중간 결과는 안나옴, 최종 결과만 나옴.

