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
 # refCount
 */
/**
 
 커넥터블 옵져버블 타입 익스텐션에 구현되어있다.
 일반 옵져버블에서는 사용할 수 없다.
 
 파라미터는 없고, 옵져버블을 리턴한다.
 RefCount() 커넥터블 옵져버블을 통해 생성하는 특별한 옵져버블이다.(레프카운트 옵져버블)
 구독자가 구독을 중지하고, 다른 구독자가 없다면, 커넥터블 옵져버블에서 시퀀스를 중지한다.
 새로운 구독자가 추가되면 다시 시작된다.
 */
let bag = DisposeBag()
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().publish().refCount() //내부에서 connect()를 호출한다.

let observer1 = source
    .subscribe { print("🔵", $0) }

//source.connect()


DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    observer1.dispose()
}
//중지되고 나면, 디스커넥트된다.

DispatchQueue.main.asyncAfter(deadline: .now() + 7) { //7초뒤 새로운 구독자가 추가되면, 다시 커넥트가 된다. 새로운 시퀀스가 시작된다.
    let observer2 = source.subscribe { print("🔴", $0) }

    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer2.dispose()
    }
}


