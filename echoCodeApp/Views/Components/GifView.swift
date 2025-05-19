//
//  GifView.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import SwiftUI
import WebKit

struct GifView: UIViewRepresentable {
    
    private let name: String
    private let color: Color
    
    init(name: String, background: Color = .white) {
        self.name = name
        self.color = background
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        do {
            guard let url = Bundle.main.url(forResource: name, withExtension: "gif") else { throw URLError(.badURL) }
            let data = try Data(contentsOf: url)
            
            webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
            
            webView.scrollView.isScrollEnabled = false
            webView.isOpaque = false
            webView.backgroundColor = .white
        } catch {
            print(error.localizedDescription)
        }
        
        print(webView.frame.width)
        print(webView.frame.height)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}
