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
 # single
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

//원본 옵져버블에서 첫번째 요소만 방출하거나 조건에 일치하는 첫번째 요소만 방출한다. 두개 이상의 방출을 하는 경우에는 에러가 발생한다.
Observable.just(1)
    .single()
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)
    

Observable.from(numbers)
    .single() //요소가 방출되는 것은 보이지만, completed가 아닌 error이벤트가 전달된다. 단 하나의 요소만 방출되어야 정상적으로 방출된다.
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)

Observable.from(numbers)
    .single{ $0 == 3 } //요소가 방출되는 것은 보이지만, completed가 아닌 error이벤트가 전달된다. 단 하나의 요소만 방출되어야 정상적으로 방출된다.
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)

let subject = PublishSubject<Int>()

subject.single()
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

subject.onNext(100)
//하나의 요소가 방출되었다고 해서 바로 컴플리트가 뜨면 안된다. 원본 옵져버블에서 complete이벤트가 전달되면 하나의 요소가 방출된 상태라면 completed가 전달된다.
//그 이후 추가 요소가 onNext가 되면 에러가 생긴다.
//subject.onNext(101) //error
subject.onCompleted()


