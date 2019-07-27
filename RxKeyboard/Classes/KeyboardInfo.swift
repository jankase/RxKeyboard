//
// Created by Jan Kase on 2019-07-24.
// Copyright (c) 2019 Jan Kaše. All rights reserved.
//

import UIKit

public protocol KeyboardInfo {
  var beginFrame: CGRect { get }
  var endFrame: CGRect { get }
}

internal protocol KeyboardInfoInternal: KeyboardInfo {
  init?(keyboardNotification aNotification: Notification)
}

public extension KeyboardInfo {
  func beginFrameInViewCoordinateSystem(_ aView: UIView) throws -> CGRect {
    return try _convertFrame(beginFrame, toView: aView)
  }

  func endFrameInViewCoordinateSystem(_ aView: UIView) throws -> CGRect {
    return try _convertFrame(endFrame, toView: aView)
  }

  private func _convertFrame(_ aFrame: CGRect, toView aView: UIView) throws -> CGRect {
    guard let theWindow = aView.window else {
      throw KeyboardInfoError.viewIsNotInWindowHierarchy
    }
    let theWindowFrame = _convertScreenFrame(aFrame, toWindow: theWindow)
    return aView.convert(theWindowFrame, from: nil)
  }

  private func _convertScreenFrame(_ aFrame: CGRect, toWindow aWindow: UIWindow) -> CGRect {
    return aWindow.convert(aFrame, from: nil)
  }
}
