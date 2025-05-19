//
//  SettingsRow.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import SwiftUI

struct SettingsRow: View {
    
    let setting: Setting
    
    var body: some View {
        HStack {
            Text(setting.title)
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(.black)
        .padding(.vertical, 15)
        .padding(.horizontal, 16)
        .background(Color.settingRowBackground)
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    SettingsRow(setting: Setting(title: "Rate Us", destination: AnyView(Text("Rate Us"))))
}
