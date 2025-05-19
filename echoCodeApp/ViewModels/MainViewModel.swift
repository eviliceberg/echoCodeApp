//
//  MainViewModel.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var allAnimals: [Animal] = [Animal(id: 0, name: "Cat", image: .cat, backgroundColor: .cat), Animal(id: 1, name: "Dog", image: .dog, backgroundColor: .dog)]
    @Published var fromHumanToPet = true
    @Published var animalSelectedId: Int = 0
    
}
