//
//  AnimalSection.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import SwiftUI

struct AnimalSection: View {
    
    let animal: ImageResource
    let backgroundColor: Color
    
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Image(animal)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
                .padding(15)
                .background(backgroundColor)
                .clipShape(.rect(cornerRadius: 10))
                .opacity(isSelected ? 1.0 : 0.5)
        }
        .animation(.smooth, value: isSelected)
    }
}

#Preview {
    AnimalSection(animal: .cat, backgroundColor: .blue.opacity(0.6), isSelected: true)
}
