//
//  EmployeeHubApp.swift
//  EmployeeHub
//
//  Created by Akanksha on 05/08/26.
//

import SwiftUI

@main
struct EmployeeHubApp: App {
    var body: some Scene {
        WindowGroup {
            EmployeeListView(
                viewModel: AppContainer.shared.makeEmployeeListViewModel()
            )
        }
    }
}
