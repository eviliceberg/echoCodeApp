//
//  TranslationView.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import SwiftUI

struct TranslationView: View {
    
    let translatedText: String
    
    var body: some View {
        ZStack {
            Text(translatedText)
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
                .lineLimit(5)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 142)
                .background(.settingRowBackground)
                .clipShape(.rect(cornerRadius: 16))
                .shadow(radius: 5)
                .overlay(alignment: .bottomTrailing) {
                    Image(.polygon2)
                        .resizable()
                        .scaledToFit()
                        .offset(x: -20, y: 128)
                }
        }
        
       
    }
}

#Preview {
    TranslationView(translatedText: "akfh;kdsFLVNGGSDVBIUSFGKJSVBJKSDBVUIPSRBVUS`VJKBF`KJVBKJ`FSBVSVUIRHhudhioarehg;ouabvuiearbvieurbvuairbvairuvbuiabviapeuvbpeirugheriddddddddjksdfjkshfjkd")
        .padding(.horizontal, 48)
}
