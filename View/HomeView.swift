//
//  HomeView.swift
//  XOXGame
//
//  Created by ali ata haktan çetinkol on 20.05.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedSize: Int? = nil
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("XOX OYUNU")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.top, 60)

                Text("Tahta Boyutu Seçin")
                    .font(.title2)
                    .foregroundColor(colorScheme == .dark ? .white : .black)

                ForEach([3, 5, 7], id: \.self) { size in
                    NavigationLink(
                        destination: GameView(viewModel: GameViewModel(size: size)),
                        tag: size,
                        selection: $selectedSize
                    ) {
                        Button(action: {
                            selectedSize = size
                        }) {
                            Text("\(size) x \(size)")
                                .frame(width: 150, height: 50)
                                .background(colorScheme == .dark ? Color.blue.opacity(0.7) : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .background(colorScheme == .dark ? Color.black : Color.white)
            .ignoresSafeArea()
        }
    }
}
