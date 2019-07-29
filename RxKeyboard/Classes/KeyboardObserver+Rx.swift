//
// Created by Jan Kase on 2019-07-25.
// Copyright (c) 2019 Jan Kaše. All rights reserved.
//

import RxCocoa
import RxRelay
import RxSwift
import UIKit

public extension Reactive where Base: KeyboardObserver {
  func heightInView(_ aView: UIView) -> Driver<CGFloat> {
    guard let theBase = base as? KeyboardObserverInternal else {
      return Driver.just(0)
    }
    return theBase.currentKeyboardInfo
        .map { anEndKeyboardInfo -> CGFloat in try anEndKeyboardInfo?.endFrameInViewCoordinateSystem(aView).height ?? 0 }
        .asDriver(onErrorJustReturn: 0)
  }
}
