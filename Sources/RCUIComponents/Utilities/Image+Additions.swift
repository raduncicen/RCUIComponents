//
//  Image+Extensions.swift
//  DerayahSmart
//
//  Created by Radun Çiçen on 23.09.2025.
//

import SwiftUI

extension Image {
  public func isResizable(_ isResizable: Bool, capInsets: EdgeInsets = EdgeInsets(), resizingMode: Image.ResizingMode = .stretch) -> Image {
    if isResizable {
      self.resizable(capInsets: capInsets, resizingMode: resizingMode)
    } else {
      self
    }
  }
}
