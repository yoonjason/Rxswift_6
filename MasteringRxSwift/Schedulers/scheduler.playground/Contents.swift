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
 # Scheduler
 */
/**
 Cocoa - GCD
 Rxswift - Scheduler
 
 Scheduler - 특정 코드가 실행되는 컨텍스트를 추상화 한 것이다. 컨텍스트는 로우 레벨 쓰레드가 될 수도 있고, 디스패치큐나 오퍼레이션 큐가 될 수도 있다.
 쓰케쥴러는 추상화된 컨텍스트이기 때문에 쓰레드와 1:1로 매칭되지않는다, 하나의 쓰레드에 두개 이상의 개별 스케줄러가 존재하거나 하나의 스케줄러가 두개 이상의 쓰레드에 걸쳐있는 경우도 있다.
 
 큰 틀에서 보면 GCD와 유사하고 몇 가지 규칙에 따라서 스케쥴러를 사용하면된다.
 
 GCD - MainQueue, GlobalQueue
 RxSwift - MainScheduler, BackgroundScheduler
 
 serial
 - CurrentThreadScheduler 스케쥴러를 별도 지정하지않는다면 이 스케줄러가 사용된다.
 - MainScheduler - UI업데이트시 사용(=메인큐)
 - SerialDispatchQueueScheduler - 작업을 실행할 디스패치큐를 직접 지정하고 싶다면 사용한다.
 
 concurrent
 - ConcurrentDispatchQueueScheduler - 작업을 실행할 디스패치큐를 직접 지정하고 싶다면 사용한다.
 - OperationQueueScheduler - 실행 순서를 제어하거나 동시에 실행가능한 작업 수를 제한하고 싶다면 사용한다.
 
 앞에서 설명한 메인스케줄러는 시리얼 디스패치큐 스케줄러의 일종이다.
 
 백그라운드 작업을 실행할 때는 DispatchQueueScheduler를 사용한다.
 
 TestScheduler - 유닛테스트
 CustomScheduler - 커스텀
 
 1.옵져버블이 생성되는 시점을 알아야한다.
 
 */
let bag = DisposeBag()

let backgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .subscribe(on: MainScheduler.instance)
    .filter { num -> Bool in
    print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
    return num.isMultiple(of: 2)
}
    .observe(on: backgroundScheduler)
    .map { num -> Int in
    print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
    return num * 2
}
    .observe(on: MainScheduler.instance)
    .subscribe {
    print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe")
    print($0)
}
    .disposed(by: bag)

//옵져버블이 어떤 요소를 방출하고 어떻게 처리해야될지를 나타낼뿐이다.

//바로 구독이 시작되는 시점이다.


//커런트 스케줄러
//메인스레드에서 실행된다.
/**
 
 observe(on:) 연산자를 실행할 스케줄러를 지정한다.이어지는 연산자들이 작업을 실행할 스케줄러를 지정한다. 다른 스케줄러로 변경하기 전까지 계속 사용된다.
 subscribe(on:): 구독을 시작하고 종료할 때 사용할 스케줄러를 지정한다. 구독을 시작하면 옵져버블에서 새로운 이벤트가 방출된다. 이벤트를 방출할 스케줄러를 지정한다.
 crate연산자로 구현한 코드 역시 이 메서드로 지정한 스케줄러에서 실행된다. 메서드를 사용하지않는다면, subscribe 메서드가 호출된 스케줄러에서 새로운 시퀀스가 시작된다.
 서브스크라이브 메서드가 호출되는 스케줄러를 지정하는 것이 아니다. 이어지는 연사자의 스케줄러를 지정하는 것도 아니다.(observe(on:))
 옵져버블이 시작되는 시점에 어떤 스케줄러를 사용할지 지정하는 것이다. observe(on:)메서드와 달리 호출 시점이 중요하지 않다.
 
 MainScheduler는 instance속성으로 사용할 수 있다.
 옵져버블이 시작될 때
 */
