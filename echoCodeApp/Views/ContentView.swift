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
            LinearGradient(colors: [.green.opacity(0.01), .green.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            header
            
            tabBar
            
            VStack(spacing: 24) {
                controlsSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                
                if vm.dogIsSelected {
                    VStack {
                        Image(.dog)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 184)
                            .padding(.top, 36)
                    }
                    .frame(maxWidth: .infinity)
                    .transition(.move(edge: .trailing))
                } else {
                    VStack {
                        Image(.cat)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 184)
                            .padding(.top, 36)
                            .transition(.move(edge: .leading))
                    }
                    .frame(maxWidth: .infinity)
                    .transition(.move(edge: .leading))
                }
                
            }
            .animation(.easeInOut, value: vm.dogIsSelected)
            
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
    
    private var tabBar: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 48) {
                SettingButton(image: .messages2, text: "Translator", isSelected: vm.selectedMainScreen)
                    .onTapGesture {
                        if !vm.selectedMainScreen {
                            withAnimation {
                                vm.selectedMainScreen = true
                            }
                        }
                    }
                
                SettingButton(image: .settings, text: "Clicker", isSelected: !vm.selectedMainScreen)
                    .onTapGesture {
                        if vm.selectedMainScreen {
                            withAnimation {
                                vm.selectedMainScreen = false
                            }
                        }
                    }
            }
            .padding(19)
            .background(.white)
            .clipShape(.rect(cornerRadius: 16))
        }
    }
    
    private var controlsSection: some View {
        HStack(spacing: 35) {
            VStack {
                if vm.recording == true {
                    GifView(name: "sound")
                        .allowsHitTesting(false)
                        .clipShape(.rect(cornerRadius: 16))
                        .padding(8)
                        .overlay(alignment: .bottom) {
                            Text("Recording...")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .padding(.bottom, 24)
                        }
                } else if vm.recording == false {
                    VStack {
                        Image(.microphone2)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .padding()
                        
                        Text("Start Speak")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(maxHeight: .infinity)
                    
                }
            }
            .frame(width: 163)
            .background(.white)
            .clipShape(.rect(cornerRadius: 16))
            .shadow(radius: 5)
            .onTapGesture {
                withAnimation {
                    if vm.recording == true {
                        vm.recording = false
                    } else {
                        vm.recording = true
                    }
                }
            }
            
            VStack(spacing: 12) {
                AnimalSection(animal: .cat, backgroundColor: .cat, isSelected: !vm.dogIsSelected)
                        .onTapGesture {
                            guard vm.dogIsSelected else { return }
                            
                            vm.dogIsSelected.toggle()
                        }
                
                AnimalSection(animal: .dog, backgroundColor: .dog, isSelected: vm.dogIsSelected)
                        .onTapGesture {
                            guard !vm.dogIsSelected else { return }
                            
                            vm.dogIsSelected.toggle()
                        }
            
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .frame(maxHeight: .infinity)
            .background(.white)
            .clipShape(.rect(cornerRadius: 16))
            .shadow(radius: 5)
        }
        .frame(height: 176)
    }
    
}

#Preview {
    MainView()
}
