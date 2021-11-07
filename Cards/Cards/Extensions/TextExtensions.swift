//
//  TextExtensions.swift
//  Cards
//
//  Created by Ebubekir Sezer on 5.11.2021.
//

import SwiftUI

extension Text {
  func scalableText(font: Font = Font.system(size: 1000)) -> some View {
    self
      .font(font)
      .minimumScaleFactor(0.01)
      .lineLimit(1)
  }
}
