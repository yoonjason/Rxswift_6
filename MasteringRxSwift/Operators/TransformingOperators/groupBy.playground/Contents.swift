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
 # groupBy
 */

let disposeBag = DisposeBag()
let words = ["Apple", "Banana", "Orange", "Book", "City", "Axe"]


/**
 
 그룹핑할 때 사용된다.
 
 개별 옵져버블을 통해 방출된다.
 GroupedObservable이 방출
 
 */

Observable.from(words)
    .groupBy { $0.count }
    .subscribe {
    print($0)
}
    .disposed(by: disposeBag)

/**
 
 4개의 옵져버블 방출,
 문자열 길이를 기준으로 그룹핑 했을 때 4개의 그룹이 나왔기 때문이다.
 */



Observable.from(words)
    .groupBy { $0.count }
    .subscribe(onNext: {
    print("== \($0.key)")
    $0.subscribe {
        print("\($0)")
    }
})
    .disposed(by: disposeBag)

Observable.from(words)
    .groupBy { $0.count }
    .flatMap { $0.toArray() }
    .subscribe{
        print("toArray 사용!\($0)")
    }
     .disposed(by: disposeBag)



Observable.from(words)
//    .groupBy { $0.count }
    .groupBy{ $0.first ?? Character("")}
    .flatMap { $0.toArray() }
    .subscribe(onNext: {
    print(" 첫번째 문자열!\($0)")
})
     .disposed(by: disposeBag)


//홀,짝으로 구분하기
Observable.range(start: 1, count: 10)
    .groupBy{ $0.isMultiple(of: 2)}
    .flatMap{ $0.toArray() }
    .subscribe{
        print($0)
    }.disposed(by: disposeBag)
