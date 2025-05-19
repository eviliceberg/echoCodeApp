//
//  Animal.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import Foundation
import SwiftUI

struct Animal: Identifiable, Hashable {
    let id: Int
    let name: String
    let image: ImageResource
    let backgroundColor: Color
}
