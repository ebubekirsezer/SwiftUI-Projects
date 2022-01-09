//
//  SettingsView.swift
//  MacMarkDown
//
//  Created by Ebubekir Sezer on 8.01.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("editorFontSize") var editorFontSize: Int = 14
    
    var body: some View {
        Stepper(value: $editorFontSize, in: 10...30) {
            Text("Font Size: \(editorFontSize)")
        }
        .frame(width: 260, height: 80)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
