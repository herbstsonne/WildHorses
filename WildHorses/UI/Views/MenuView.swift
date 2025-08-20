//
//  MenuView.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 17.08.25.
//

import SwiftUI
import SpriteKit

struct MenuView: View {

  @EnvironmentObject private var settings: Settings
  @EnvironmentObject private var gameState: GameState
  @Environment(\.verticalSizeClass) private var verticalSizeClass
  @State private var startGameCatchHorses = false
  @State private var navigationPath: [RouteViews] = []
  @State private var enableButton: Bool = false
  
  var body: some View {
    NavigationStack(path: $navigationPath) {
      VStack {
        if verticalSizeClass == .regular {
          HStack {
            Form {
              settingsView()
            }
            .frame(width: 400)
            Spacer()
          }
          .padding()
        } else {
          HStack {
            settingsView()
            Spacer()
          }
          .padding()
          .background(
            Image("racetrack")
              .resizable()
              .scaledToFill()
          )
          .ignoresSafeArea()
        }
      }
      .onAppear {
        gameState.score = 0
      }
      .onChange(of: settings.playerName) {
        if settings.playerName.isEmpty {
          enableButton = false
        } else {
          enableButton = true
        }
      }
      .navigationDestination(for: RouteViews.self) { route in
        switch route {
        case .catchHorses:
          CatchHorsesView()
        }
      }
    }
  }
}

extension MenuView {
  
  private func settingsView() -> some View {
    VStack(alignment: .leading) {
      Text("Pferdespiele für mein Spätzchen")
        .font(.largeTitle)
        .padding(.top, 24)
      TextField("Spielername:", text: $settings.playerName)
      Stepper("Anzahl Pferde: \(settings.numberOfHorses)", value: $settings.numberOfHorses, in: 1...10)
        .padding(.trailing, 20)
      HStack {
        Text("Geschwindigkeit: \(UInt(51 - settings.speed))")
        Slider(value: $settings.speed, in: 1...50, step: 1)
      }
      Button("Spiele Wildpferde fangen!") {
        navigationPath.append(.catchHorses)
      }
      .disabled(!enableButton)
    }
  }
}
