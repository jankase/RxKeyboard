//
// Created by Jan Kase on 2019-07-24.
// Copyright (c) 2019 Jan Kaše. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
import Swinject

public protocol KeyboardObserver {
  func startObserving()
}

internal protocol KeyboardObserverInternal: KeyboardObserver {
  var currentKeyboardInfo: PublishRelay<KeyboardInfo?> { get }
  var container: Container { get set }
}
