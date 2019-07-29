//
// Created by Jan Kase on 2019-07-24.
// Copyright (c) 2019 Jan Kaše. All rights reserved.
//

import RxCocoa
import RxRelay
import RxSwift
import Swinject
import UIKit

public protocol KeyboardObserver {
  func startObserving()
}

internal protocol KeyboardObserverInternal: KeyboardObserver {
  var currentKeyboardInfo: PublishRelay<KeyboardInfo?> { get }
  var container: Container? { get set }
}

public extension KeyboardObserver {
  static var `default`: KeyboardObserver {
    let theResult = KeyboardObserverImpl()
    theResult.notificationCenter = .default
    return theResult
  }

  func rx_heightInView(_ aView: UIView) -> Driver<CGFloat> {
    guard let theBase = self as? KeyboardObserverInternal else {
      return Driver.just(0)
    }
    return theBase.currentKeyboardInfo
        .map { anEndKeyboardInfo -> CGFloat in try anEndKeyboardInfo?.endFrameInViewCoordinateSystem(aView).height ?? 0 }
        .asDriver(onErrorJustReturn: 0)

  }
}
