//
//  SettingButton.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import SwiftUI

struct SettingButton: View {
    
    let image: ImageResource
    let text: String
    
    var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(image)
            
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
        }
        .opacity(isSelected ? 1.0 : 0.5)
    }
}

#Preview {
    SettingButton(image: .settings, text: "Settings", isSelected: false)
}
