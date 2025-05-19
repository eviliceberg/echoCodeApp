//
//  Setting.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import SwiftUI

struct Setting: Identifiable {
    
    let id: String = UUID().uuidString
    let title: String
    let destination: AnyView
    
}
