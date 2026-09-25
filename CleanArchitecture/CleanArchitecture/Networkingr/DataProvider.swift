//
//  DataProvider.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//
import Foundation
protocol DataProvider {

    func get(endpoint: Endpoint) async throws -> Data

    func post(
        endpoint: Endpoint,
        body: Data
    ) async throws -> Data

    func put(
        endpoint: Endpoint,
        body: Data
    ) async throws -> Data

    func delete(
        endpoint: Endpoint
    ) async throws -> Data
}
