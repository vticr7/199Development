//
//  ActiveVibeApp.swift
//  ActiveVibe
//
//  Created by Vaibhav  Tiwary on 09/01/24.
//

import SwiftUI
import FirebaseCore
@main
struct Mobilicius: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
