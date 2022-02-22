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

class ControlPropertyControlEventRxCocoaViewController: UIViewController {

    let bag = DisposeBag()

    @IBOutlet weak var colorView: UIView!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var redComponentLabel: UILabel!
    @IBOutlet weak var greenComponentLabel: UILabel!
    @IBOutlet weak var blueComponentLabel: UILabel!

    @IBOutlet weak var resetButton: UIButton!

    private func updateComponentLabel() {
        redComponentLabel.text = "\(Int(redSlider.value))"
        greenComponentLabel.text = "\(Int(greenSlider.value))"
        blueComponentLabel.text = "\(Int(blueSlider.value))"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        redSlider.rx.value
            .map { "\(Int($0))" }
            .bind(to: redComponentLabel.rx.text)
            .disposed(by: bag)

        greenSlider.rx.value
            .map { "\(Int($0))" }
            .bind(to: greenComponentLabel.rx.text)
            .disposed(by: bag)

        blueSlider.rx.value
            .map { "\(Int($0))" }
            .bind(to: blueComponentLabel.rx.text)
            .disposed(by: bag)

//        Observable.combineLatest([redSlider.rx.value, greenSlider.rx.value, blueSlider.rx.value])
//            .map { UIColor(red: $0[0], green: $0[1], blue: $0[3], alpha: 1.0) }
//            .bind(to: colorView.rx.backgroundColor)
//            .disposed(by: bag)

//        Observable.combineLatest( [redSlider.rx.value, greenSlider.rx.value, blueSlider.rx.value] )
//            .map { UIColor(red: CGFloat($0[0]) / 255, green: CGFloat($0[1]) / 255, blue: CGFloat($0[2]) / 255, alpha: 1.0) }
//            .bind(to: colorView.rx.backgroundColor)
//            .disposed(by: bag)

//        Observable.combineLatest([redSlider.rx.value, greenSlider.rx.value, blueSlider.rx.value])
//            .map {
//            UIColor(red: ($0[0]) / 255, green: ($0[0]) / 255, blue: ($0[0]) / 255, alpha: 1.0)
//        }



        resetButton.rx.tap
            .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.colorView.backgroundColor = .black
            self.redSlider.value = 0
            self.greenSlider.value = 0
            self.blueSlider.value = 0

            self.updateComponentLabel()
        })
            .disposed(by: bag)
    }
}

/**
 Observable -> ControlProperty -> Subscriber 가장 최근 이벤트를 리플레이한다.
 ControlEvent -> Subscriber 가장 최근 이벤트를 리플레이 하지 않는다. 구독 이후에 전달된 이벤트만 전달받는다.
 
 */
