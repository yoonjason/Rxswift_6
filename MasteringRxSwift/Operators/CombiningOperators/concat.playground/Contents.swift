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
 # concat
 */

let bag = DisposeBag()
let fruits = Observable.from(["π", "π", "π₯", "π", "π", "π"])
let animals = Observable.from(["πΆ", "π±", "πΉ", "πΌ", "π―", "π΅"])

//λκ°μ μ΅μ Έλ²λΈ μ°κ²°ν  λ μ¬μ©
//νμ λ©μλλΆν° μ¬μ©
Observable.concat([fruits, animals])
    .subscribe {
    print($0)
}.disposed(by: bag)

//μΈμ€ν΄μ€ λ©μλ μ¬μ©
fruits.concat(animals)
    .subscribe {
    print($0)
}.disposed(by: bag)

animals.concat(fruits)
    .subscribe {
    print($0)
}.disposed(by: bag)

//λ¨μν νλμ μ΅μ Έλ²λΈ λ€μ λ€μ μ΅μ Έλ²λΈμ λΆμΈλ€.









