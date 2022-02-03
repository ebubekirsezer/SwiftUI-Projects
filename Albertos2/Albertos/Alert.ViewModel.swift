//
//  Alert.ViewModel.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 31.01.2022.
//

import SwiftUI

extension Alert {
    struct ViewModel: Identifiable {
        let title: String
        let message: String
        let buttonText: String
        var id: String { title + message + buttonText }
        let buttonAction: (() -> Void)?
    }
}
