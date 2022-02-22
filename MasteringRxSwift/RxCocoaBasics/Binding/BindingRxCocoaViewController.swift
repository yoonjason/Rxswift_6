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
import RxCocoa
/**
 데이터 생산자와 소비자가 있다.
 생산자는 옵져버블이고, 소비자는 UI컴포넌트이다. 소비자는 적절한 방식으로 적절하게 소비한다.
 binder는 에러 이벤트를 받지않는다. 에러 이벤트가 발생하면 크래시가 일어나거나, 이벤트가 종료된다.
 
 */

class BindingRxCocoaViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var valueField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueLabel.text = ""
        valueField.becomeFirstResponder()
        
        valueField.rx.text
            .bind(to: valueLabel.rx.text) //옵져버블이 방출한 이벤트를 옵져버에게 전달한다.
            .disposed(by: disposeBag)
        
//        valueLabel.rx.text //바인더 속성
        
//        valueField.rx.text
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] in
//                guard let self = self else { return }
//                self.valueLabel.text = $0
//            }) //메인쓰레드에서 돌긴 하지만 안돌수도 있다.
//            .disposed(by: disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        valueField.resignFirstResponder()
    }
}

/**
 Traits
 UI에 특화된 옵져버블이다. UI바인딩에서 데이터 생성자 역할을 수행한다.
 ConrolProperty
 ControlEvent
 Driver
 Signal
 --> Main Thread
 
 UI업데이트 코드를 작성할 때 스케줄러를 작성할 필요가 없다.
 Error 이벤트를 전달하지않는다. 올바른 쓰레드에서 업데이트 되는 것을 보장한다.
 
 옵져버블을 구독하면 기본적으로 새로운 시퀀스를 시작한다.
 동일한 시퀀스를 구현한다
 
 트레이트는 옵셔널이지만, 사용하면 좋다.
 UI구현에 있어서 매우 중요한 요소이다.
 
 */
