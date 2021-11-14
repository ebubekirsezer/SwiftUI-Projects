//
//  RenderableView.swift
//  Cards
//
//  Created by Ebubekir Sezer on 13.11.2021.
//

import SwiftUI

struct RenderableView<Content>: View where Content: View {
  @EnvironmentObject var viewState: ViewState

  let content: () -> Content
  @Binding var card: Card

  init(
    card: Binding<Card>,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content
    self._card = card
  }

  var body: some View {
    content()
      // Share
      .onChange(of: viewState.shouldScreenshot) { _ in
        if viewState.shouldScreenshot {
          viewState.shouldScreenshot = false
          card.shareImage = content().screenShot(size: Settings.cardSize)
        }
      }
      // Thumbnail
      .onDisappear {
        DispatchQueue.main.async {
          if let image = content().screenShot(size: Settings.thumbnailSize(size: Settings.cardSize)) {
            _ = image.save(to: card.id.uuidString)
            card.image = image
          }
        }
      }
  }
}

private extension View {
  func screenShot(size: CGSize) -> UIImage? {
    let controller = UIHostingController(rootView: self)
    guard let renderView = controller.view,
      let window = UIApplication.shared.windows.first else { return nil }
    renderView.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
    window.rootViewController?.view.addSubview(renderView)

    let viewSize = controller.sizeThatFits(in: size)
    renderView.bounds = CGRect(origin: .zero, size: viewSize)
    renderView.sizeToFit()

    let image = UIGraphicsImageRenderer(bounds: renderView.bounds).image { _ in
      renderView.drawHierarchy(in: renderView.bounds, afterScreenUpdates: true)
    }
    renderView.removeFromSuperview()
    return image.resize(to: size)
  }
}
