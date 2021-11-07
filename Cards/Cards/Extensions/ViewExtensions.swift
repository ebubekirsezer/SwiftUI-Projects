//
//  ViewExtensions.swift
//  Cards
//
//  Created by Ebubekir Sezer on 4.11.2021.
//

import SwiftUI

extension View {
    func resizableView(transform: Binding<Transform>) -> some View {
        return modifier(ResizableView(transform: transform))
    }
}
