//
//  EmployeeView.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//
import SwiftUI

struct EmployeeListView: View {

    @State private var viewModel:
        EmployeeListViewModel

    init(
        viewModel: EmployeeListViewModel
    ) {
        _viewModel = State(
            initialValue: viewModel
        )
    }

    var body: some View {

        NavigationStack {

            Group {

                if viewModel.isLoading {

                    ProgressView()

                } else if let error =
                    viewModel.errorMessage {

                    VStack(spacing: 12) {

                        Text("Something went wrong")

                        Text(error)
                            .font(.caption)
                            .foregroundStyle(
                                .secondary
                            )
                    }

                } else {

                    List(
                        viewModel.employees
                    ) { employee in

                        VStack(
                            alignment: .leading,
                            spacing: 6
                        ) {

                            Text(employee.name)
                                .font(.headline)

                            Text(employee.email)
                                .font(.subheadline)

                            Text(employee.companyName)
                                .font(.caption)
                                .foregroundStyle(
                                    .secondary
                                )
                        }
                    }
                }
            }
            .navigationTitle("Employees")
        }
        .task {

            await viewModel.loadEmployees()
        }
    }
}
