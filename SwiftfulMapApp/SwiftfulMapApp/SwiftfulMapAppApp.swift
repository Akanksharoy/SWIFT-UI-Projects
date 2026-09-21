//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Akanksha on 15/06/26.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    @StateObject private var vm:LocationViewModel = LocationViewModel()
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
