//
//  EmployeeListView.swift
//  EmployeeHub
//
//  Created by Akanksha on 05/08/26.
//
import SwiftUI
import Combine


struct EmployeeListView: View {

    @StateObject
    private var viewModel: EmployeeListViewModel

    init(viewModel: EmployeeListViewModel) {

        _viewModel = StateObject(wrappedValue: viewModel)

    }

    var body: some View {

        NavigationStack {

            List(viewModel.employees) { employee in

                VStack(alignment: .leading) {

                    Text(employee.fullName)
                        .font(.headline)

                    Text(employee.department)
                        .font(.subheadline)

                    Text(employee.email)
                        .font(.caption)

                }

            }
            .navigationTitle("Employees")
            .onAppear {

                viewModel.loadEmployees()

            }

        }

    }

}

#Preview {

    EmployeeListView(
        viewModel: AppContainer.shared.makeEmployeeListViewModel()
    )

}
