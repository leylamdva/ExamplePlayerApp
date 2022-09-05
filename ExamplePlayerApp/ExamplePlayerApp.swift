//
//  ExamplePlayerAppApp.swift
//  ExamplePlayerApp
//
//  Created by Leyla Mammadova on 9/5/22.
//

import SwiftUI

@main
struct ExamplePlayerApp: App {
    @StateObject var audioManager = AudioManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
