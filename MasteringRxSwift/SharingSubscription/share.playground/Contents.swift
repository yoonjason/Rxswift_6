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
 # share
 */
/**
 멀티캐스트 연산자를 호출한다. 하나의 서브젝트를 통해 시퀀스를 공유한다
 
 scope: 이 시퀀스의
 연산자의 리턴형은 옵져버블로 선언되어있다.
 쉐어연산자가 리턴하는 옵져버블은 refcount옵져버블이다.
 
 새로운 구독자가 없다면 디스커넥트가 된다.
 새로운 구독자가 추가되면,(새로운 커넥션이 시작되면) 새로운 서브젝트가 생성되며, 디스커넥트되면 서브젝트가 종료된다.
 다른 커넥션과 격리된다.
 replay: 버퍼사이즈
 scope: 모든 구독자가 같은 subject를 구독하고 있다.(하나의 서브젝트를 공유한다.) 종료된 시퀀스가 공유되는 것은 아니다.
 
 replay: 리플레이 버퍼의 크기 파라미터로 0을 전달하면, multicast를 호출할 때 publishsubject를 호출
 0보다 큰값을 전달하면 ReplaySubject를 호출한다.
 
 multicast는 하나의 시퀀스를 통해 subject를 공유한다.
 
 리턴형은 옵져버블로 선언되어있고, 멀티캐스트 연산자를 호출하고 이어서 refcount 연산자를 호출하고 있다. refcount옵져버블이다.
 새로운 구독자가 추가되면 자동으로 커넥트되고 구독자가 없다면 디스커넥트가 된다.
 
 scope:
 새로운 구독자가 추가되면(새로운 커넥션이 시작되면) 새로운 서브젝트가 생성(시작)된다. 커넥션이 종료되면 서브젝트는 사라진다.
 커넥션마다 새로운 서브젝트가 시작되기 때문에, 커넥션은 다른 커넥션과 격리된다.
 
 forever
 모든 커넥션이 하나의 서브젝트를 공유하게된다.
 
 */
let bag = DisposeBag()

//let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().share() //refcount 옵져버블

let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().share(replay:5) //refcount 옵져버블, 갖고 있는 버퍼의 사이즈, replay옵져버블과 동일하다.

//let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().share(replay:5, scope: .forever) //refcount옵져버블타입이다. replay를 사용하게되면 버퍼를 가지게된다. 그래서 뒤늦게 시작해도 이전 값을 전달 받을 수 있다. 하지만 종료된 것과 동일한 것은 아니다.

let observer1 = source
    .subscribe { print("🔵", $0) }

let observer2 = source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("🔴", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    observer1.dispose()
    observer2.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    let observer3 = source.subscribe { print("⚫️", $0) }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer3.dispose()
    }
}

/**
 2022-02-22 15:05:38.115: share.playground:43 (__lldb_expr_448) -> isDisposed 서브젝트가 사라진다.
 2022-02-22 15:05:40.315: share.playground:43 (__lldb_expr_448) -> subscribed 서브젝트가 생성된다.
 
 */


