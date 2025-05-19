//
//  MainViewModel.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var fromHumanToPet = true
    @Published var dogIsSelected: Bool = true
    
    @Published var recording: Bool? = false
    @Published var selectedMainScreen: Bool = true
    
}
