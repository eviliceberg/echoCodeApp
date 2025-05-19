//
//  ContentView.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var vm = MainViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green.opacity(0.01), .green.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            header
            
            VStack {
                HStack {
                    VStack(spacing: 12) {
                        ForEach(vm.allAnimals, id: \.self) { animal in
                            AnimalSection(animal: animal.image, backgroundColor: animal.backgroundColor, isSelected: animal.id == vm.animalSelectedId)
                                .onTapGesture {
                                    guard animal.id != vm.animalSelectedId else { return }
                                    
                                    vm.animalSelectedId = animal.id
                                }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 16))
                    .shadow(radius: 5)
                }
                
                
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: 36) {
            Text("Translator")
                .font(.largeTitle)
                .fontWeight(.bold)
                
            
            HStack(spacing: 0) {
                Text(vm.fromHumanToPet ? "HUMAN" : "PET")
                    .frame(maxWidth: .infinity)
                    //.background(.red)
                
                Image(.arrowSwapHorizontal)
                
                Text(vm.fromHumanToPet ? "PET" : "HUMAN")
                    .frame(maxWidth: .infinity)
                    //.background(.red)
            }
            .font(.headline)
            .fontWeight(.bold)
            .onTapGesture {
                vm.fromHumanToPet.toggle()
            }
            
            Spacer()
        }
        .padding(.top, 24)
        .padding(.horizontal, 40)
    }
    
}

#Preview {
    MainView()
}
