//
//  PencilView.swift
//  Cards
//
//  Created by Ebubekir Sezer on 8.11.2021.
//

import SwiftUI
import PencilKit

struct PencilView: View {
    
    @State private var canvas = PKCanvasView()
    
    var body: some View {
        PencilViewRepresentable(canvas: $canvas)
    }
}

struct PencilView_Previews: PreviewProvider {
    static var previews: some View {
        PencilView()
    }
}

struct PencilViewRepresentable: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    
    func makeUIView(context: Context) -> some UIView {
        canvas.drawingPolicy = .anyInput
        return canvas
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
