//
//  CardModal.swift
//  Cards
//
//  Created by Ebubekir Sezer on 4.11.2021.
//

import Foundation

enum CardModal: Identifiable {
    var id: Int {
        hashValue
    }
    case photoPicker, framePicker, stickerPicker, textPicker
    case shareSheet
}
