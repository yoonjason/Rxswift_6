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

class CustomControlPropertyViewController: UIViewController {

    let bag = DisposeBag()

    @IBOutlet weak var resetButton: UIBarButtonItem!

    @IBOutlet weak var whiteSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

//        whiteSlider.rx.value
//            .map { UIColor(white: CGFloat($0), alpha: 1.0) }
//            .bind(to: view.rx.backgroundColor)
//            .disposed(by: bag)
//
//        resetButton.rx.tap
//            .map { Float(0.5) }
//            .bind(to: whiteSlider.rx.value)
//            .disposed(by: bag)
//
//        resetButton.rx.tap
//            .map { UIColor(white: 0.5, alpha: 1.0) }
//            .bind(to: view.rx.backgroundColor)
//            .disposed(by: bag)
        
        whiteSlider.rx.color
            .bind(to: view.rx.backgroundColor)
            .disposed(by: bag)
        
        resetButton.rx.tap
            .map { _ in
                UIColor(white: 0.5, alpha: 1.0)
            }
            .bind(to: whiteSlider.rx.color.asObserver(), view.rx.backgroundColor.asObserver())
            .disposed(by: bag)
    }
}

/**
 읽기와쓰기는 control property
 
 */

extension Reactive where Base: UISlider {
    var color: ControlProperty<UIColor?> {
        return base.rx.controlProperty(
            editingEvents: .valueChanged) { (slider) in
                UIColor(white: CGFloat(slider.value), alpha: 1.0)
            } setter: { slider, color in
                var white = CGFloat(1)
                color?.getWhite(&white, alpha: nil)
                slider.value = Float(white)
            }

    }
}
