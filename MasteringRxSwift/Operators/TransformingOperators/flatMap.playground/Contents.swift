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
 # flatMap
 */

let disposeBag = DisposeBag()

let redCircle = "π΄"
let greenCircle = "π’"
let blueCircle = "π΅"

let redRectangle = "π₯"
let greenRectangle = "π©"
let blueRectangle = "π¦"

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject
    .flatMap {
    $0.asObservable()
}
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(a)

subject.onNext(b)

a.onNext(11)

b.onNext(22)

//μλ‘μ΄ μ΅μ Έλ²λΈμ ν­λͺ©μ΄ μλ°μ΄νΈλ λ λ§λ€ μλ‘μ΄ μ΅μ Έλ²λΈμ λ°©μΆνλ€. λͺ¨λ  ν­λͺ©λ€μ΄ μ΄ μ΅μ Έλ²λΈλ€μ μ΄μ©ν΄μ μ λ¬λλ€. μλ°μ΄νΈλ μ΅μ  ν­λͺ©λ κ΅¬λμλ‘ μ λ¬λλ€.
//λ€νΈμν¬ μμ²­μ κ΅¬νν  λ μ¬μ©λλ€.
//μ΅μ’μ μΌλ‘ νλμ μ΅μ Έλ²λΈμ ν΅ν΄μ κ΅¬λμλ‘ μ λ¬λλ€.

let circle = BehaviorSubject<String>(value: "")
let rectangle = BehaviorSubject<String>(value: "")

let subject1 = PublishSubject<BehaviorSubject<String>>()

//subject1
//    .flatMap { $0.asObservable() }
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)
//
//subject1.onNext(circle)
//subject1.onNext(rectangle)
//
//circle.onNext(redCircle)
//rectangle.onNext(redRectangle)


Observable.from([redCircle, greenCircle, blueCircle])
    .flatMap { circle -> Observable<String> in
    switch circle {
    case redCircle:
        return Observable.repeatElement(redRectangle)
            .take(5)
    case greenCircle:
        return Observable.repeatElement(greenRectangle)
            .take(5)
    case blueCircle:
        return Observable.repeatElement(blueRectangle)
            .take(5)
    default:
        return Observable.just("")
    }
}
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)

//λ¦¬μ νΈ μ΅μ Έλ²λΈμ ν΅ν΄μ μ§μ°μμ΄ λ°©μΆλλ€. λ¨Όμ  λ°©μΆλλ κ²½μ°λ μλ€. interLeaving
//conactmapμ μΈν°λ¦¬λΉμ΄ νμ©λμ§μλλ€.

