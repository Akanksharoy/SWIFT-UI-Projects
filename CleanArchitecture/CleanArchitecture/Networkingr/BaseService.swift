//
//  BaseService.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//
import Foundation

class BaseService {

    let environmentConfiguration:
        EnvironmentConfiguration

    let dataProvider: DataProvider

    init(
        environmentConfiguration:
            EnvironmentConfiguration,
        dataProvider: DataProvider
    ) {
        self.environmentConfiguration =
            environmentConfiguration

        self.dataProvider =
            dataProvider
    }

    func buildHeaders(
        _ additionalHeaders:
            [String: String] = [:]
    ) -> [String: String] {

        var headers =
            environmentConfiguration.defaultHeaders

        additionalHeaders.forEach {
            headers[$0] = $1
        }

        return headers
    }

    func makeEndpoint(
        path: String,
        queryItems:
            [URLQueryItem] = []
    ) -> Endpoint {

        Endpoint(
            baseURL:
                environmentConfiguration.baseURL,
            path: path,
            queryItems: queryItems,
            headers: buildHeaders()
        )
    }
}
