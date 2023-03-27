//
//  HabiThisApp.swift
//  HabiThis
//
//  Created by user on 02/03/23.
//

import SwiftUI

@main
struct HabiThisApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}
