//
//  ShareSheetView.swift
//  Cards
//
//  Created by Ebubekir Sezer on 13.11.2021.
//

import SwiftUI

struct ShareSheetView: UIViewControllerRepresentable {
  let activityItems: [UIImage]
  let applicationActivities: [UIActivity]?

  func makeUIViewController(context: Context) -> some UIViewController {
    UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: applicationActivities)
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
  }
}
