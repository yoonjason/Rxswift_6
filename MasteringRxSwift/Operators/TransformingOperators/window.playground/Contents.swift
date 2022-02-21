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
 # window
 */

let disposeBag = DisposeBag()
/**
 버퍼 연산자처럼 timespan과 maxcount를 지정해서 원본 옵져버블이 방출되는 항목들을 작은 단위의 옵져버블을 방출한다.
 버퍼연산자는 수집된 항목을 배열혈태로 방출하지만 수집된 항목을 방출하는 옵져버블을 리턴한다.
 timeSpan: 수집할 시간,
 count: 수집할 항목,
 scheduler: 스케쥴러
 Inner Observable
 */

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(5), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe {
    print($0)
    if let observable = $0.element {
        observable.subscribe {
            print("inner : ", $0)
        }
    }
}
    .disposed(by: disposeBag)

/**
 next(RxSwift.AddRef<Swift.Int>) -> Inner Observable
 next(RxSwift.AddRef<Swift.Int>)
 next(RxSwift.AddRef<Swift.Int>)
 next(RxSwift.AddRef<Swift.Int>)
 next(RxSwift.AddRef<Swift.Int>)
 */











