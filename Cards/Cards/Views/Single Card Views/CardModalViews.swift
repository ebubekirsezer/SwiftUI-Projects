//
//  CardModalViews.swift
//  Cards
//
//  Created by Ebubekir Sezer on 13.11.2021.
//

import SwiftUI

struct CardModals: ViewModifier {
    
    @EnvironmentObject var viewState: ViewState
    @Binding var card: Card
    @Binding var currentModal: CardModal?
    
    
    @State private var stickerImage: UIImage?
    @State private var images: [UIImage] = []
    @State private var frame: AnyShape?
    @State private var textElement = TextElement()
    
    
    func body(content: Content) -> some View {
        content
            .sheet(item: $currentModal, content: { item in
                switch item {
                case .stickerPicker:
                    StickerPicker(stickerImage: $stickerImage)
                        .onDisappear {
                            if let stickerImage = stickerImage {
                                card.addElement(uiImage: stickerImage)
                            }
                            stickerImage = nil
                        }
                case .photoPicker:
                    PhotoPicker(images: $images)
                        .onDisappear {
                            for image in images {
                                card.addElement(uiImage: image)
                            }
                            images = []
                        }
                case .framePicker:
                    FramePicker(frame: $frame)
                        .onDisappear {
                            if let frame = frame {
                                card.update(
                                    viewState.selectedElement, frame: frame)
                            }
                            frame = nil
                        }
                case .textPicker:
                    TextPicker(textElement: $textElement)
                        .onDisappear {
                            if !textElement.text.isEmpty {
                                card.addElement(textElement)
                            }
                            textElement = TextElement()
                        }
                case .shareSheet:
                    if let shareImage = card.shareImage {
                        ShareSheetView(activityItems: [shareImage],
                                       applicationActivities: nil)
                            .onDisappear {
                                card.shareImage = nil
                            }
                    }
                }
            })
    }
}

extension View {
    func cardModals(card: Binding<Card>, currentModal: Binding<CardModal?>) -> some View {
        modifier(CardModals(card: card, currentModal: currentModal))
    }
}
