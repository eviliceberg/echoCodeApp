//
//  ContentView.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var vm = MainViewModel()
    @State private var headerText: HeaderOptions = .translate
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.green.opacity(0.01), .green.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                header
                
                if vm.selectedMainScreen {
                    VStack(spacing: 24) {
                        controlsSection
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                        
                        selectedAnimal
                        
                    }
                    .animation(.easeInOut, value: vm.dogIsSelected)
                    .transition(.move(edge: .leading))
                } else {
                    settings
                        .padding(.horizontal, 16)
                        .padding(.top, 96)
                        .transition(.move(edge: .trailing))
                }
                
                tabBar
                
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: 36) {
            Text(headerText.rawValue.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay(alignment: .leading) {
                    if vm.recording == nil {
                        Button {
                           //close
                        } label: {
                            Image(.close)
                                .padding(8)
                                .background(.white)
                                .clipShape(.circle)
                                .padding(.leading, 16)
                            
                        }
                        .transition(.move(edge: .leading))
                    }
                }
                .animation(.none, value: vm.selectedMainScreen)
            
            if vm.selectedMainScreen {
                HStack(spacing: 0) {
                    Text(vm.fromHumanToPet ? "HUMAN" : "PET")
                        .frame(maxWidth: .infinity)
                    
                    Image(.arrowSwapHorizontal)
                    
                    Text(vm.fromHumanToPet ? "PET" : "HUMAN")
                        .frame(maxWidth: .infinity)
                }
                .font(.headline)
                .fontWeight(.bold)
                .onTapGesture {
                    vm.fromHumanToPet.toggle()
                }
                .padding(.horizontal, 40)
                .transition(.move(edge: .leading))
            }
            Spacer()
        }
        .padding(.top, 24)

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
                                headerText = .translate
                            }
                        }
                    }
                
                SettingButton(image: .settings, text: "Clicker", isSelected: !vm.selectedMainScreen)
                    .onTapGesture {
                        if vm.selectedMainScreen {
                            withAnimation {
                                vm.selectedMainScreen = false
                                headerText = .settings
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
    
    @ViewBuilder
    private var selectedAnimal: some View {
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
    
    private var settings: some View {
        VStack(spacing: 14) {
            
            ForEach(vm.settingOption) { setting in
                NavigationLink(destination: setting.destination) {
                    SettingsRow(setting: setting)
                }
            }
            
            Spacer()
        }
    }
    
}

#Preview {
    MainView()
}
