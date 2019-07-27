//
// Created by Jan Kase on 2019-07-27.
// Copyright (c) 2019 Jan Kaše. All rights reserved.
//

import Foundation
import Swinject

public class KeyboardObserverAssembly: Assembly {
  public func assemble(container aContainer: Container) {
    let theResolver = aContainer.synchronize()
    if theResolver.resolve(NotificationCenter.self) == nil {
      aContainer.register(NotificationCenter.self) { _ in NotificationCenter.default }.inObjectScope(.transient)
    }
    aContainer.register(KeyboardObserver.self) { _ in
      let theResult = KeyboardObserverImpl(container: aContainer)
      return theResult
    }
  }
}
