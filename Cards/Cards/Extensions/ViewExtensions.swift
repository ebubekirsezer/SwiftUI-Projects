//
//  ViewExtensions.swift
//  Cards
//
//  Created by Ebubekir Sezer on 4.11.2021.
//

import SwiftUI

extension View {
    func resizableView(transform: Binding<Transform>, viewScale: CGFloat = 1) -> some View {
        return modifier(ResizableView(transform: transform, viewScale: viewScale))
    }
}
