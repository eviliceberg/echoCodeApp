//
//  RepeatButton.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-20.
//

import SwiftUI

struct RepeatButton: View {
    
    @Binding var showRepeatButton: Bool
    
    var repeatButtonPressed: (() -> Void)? = nil
    
    var body: some View {
        Button {
            repeatButtonPressed?()
        } label: {
            HStack {
                Image(systemName: "arrow.clockwise")
                
                Text("Repeat")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.settingRowBackground)
            .clipShape(.rect(cornerRadius: 16))
            .shadow(radius: 5)
            .opacity(showRepeatButton ? 1 : 0)
        }

    }
}

#Preview {
    RepeatButton(showRepeatButton: .constant(true))
}
