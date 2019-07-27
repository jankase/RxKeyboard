//
// Created by Jan Kase on 2019-07-24.
// Copyright (c) 2019 Jan Kaše. All rights reserved.
//

import UIKit

public struct KeyboardInfoImpl: KeyboardInfoInternal {
  private(set) public var beginFrame: CGRect
  private(set) public var endFrame: CGRect

  public init?(keyboardNotification aNotification: Notification) {
    guard let theBeginFrame = (aNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
          let theEndFrame = (aNotification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
      return nil
    }
    beginFrame = theBeginFrame
    endFrame = theEndFrame
  }
}
