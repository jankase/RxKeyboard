//
// Created by Jan Kase on 2019-07-24.
// Copyright (c) 2019 Jan Kaše. All rights reserved.
//

import RxCocoa
import RxRelay
import RxSwift
import Swinject
import UIKit

public class KeyboardObserverImpl: KeyboardObserverInternal, ReactiveCompatible {
  private(set) internal var currentKeyboardInfo: PublishRelay<KeyboardInfo?> = .init()
  internal var container: Container
  private var _disposeBag: DisposeBag = .init()
  private var _resolver: Resolver {
    return container.synchronize()
  }

  init(container aContainer: Container) {
    container = aContainer
  }

  public func startObserving() {
    _resetOldObservers()
    guard let theNotificationCenter = _resolver.resolve(NotificationCenter.self) else {
      return
    }
    [
      UIResponder.keyboardWillShowNotification,
      UIResponder.keyboardDidChangeFrameNotification,
      UIResponder.keyboardDidHideNotification
    ].forEach { aNotificationName in
      theNotificationCenter.rx
          .notification(aNotificationName)
          .map { KeyboardInfoImpl(keyboardNotification: $0) }
          .observeOn(MainScheduler.asyncInstance)
          .bind(to: currentKeyboardInfo)
          .disposed(by: _disposeBag)
    }
  }

  private func _resetOldObservers() {
    _disposeBag = .init()
  }
}
