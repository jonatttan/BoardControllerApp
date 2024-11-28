//
//  ContentView.swift
//  ControllESP
//
//  Created by Jonattan Sousa on 28/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            if !viewModel.loading {
                VStack {
                    ForEach($viewModel.pinStatus, id: \.id) { statusItem in
                        ToggleView(pinStatusVM: statusItem)
                            .onChange(of: viewModel.pinStatus.first(where: { pinStatus in
                                pinStatus.id == statusItem.id
                            })?.state) { oldValue, newValue in
                                Task {
                                    try await viewModel.setStatus()
                                }
                            }
                    }
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            Task {
                try await viewModel.getStatus()
            }
        }
    }
}

struct ToggleView: View {
    @Binding var pinStatusVM: PinStatus
    
    var body: some View {
        
        Toggle(String(pinStatusVM.id), isOn: $pinStatusVM.state)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 10, y: 5)
    }
}

#Preview {
    ContentView()
}
