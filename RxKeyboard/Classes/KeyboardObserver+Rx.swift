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
    return base.rx_heightInView(aView)
  }
}
