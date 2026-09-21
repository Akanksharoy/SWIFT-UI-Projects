//
//  URLSessionAPIClient.swift
//  EmployeeHub
//
//  Created by Akanksha on 07/08/26.
//

import Foundation
import Combine

final class URLSessionAPIClient: APIClient {

    private let session: URLSession

    private let requestBuilder: RequestBuilder

    init(
        session: URLSession = .shared,
        requestBuilder: RequestBuilder
    ) {

        self.session = session
        self.requestBuilder = requestBuilder

    }
    
    func request<T: Decodable>(
        endpoint: Endpoint
    ) -> AnyPublisher<T, NetworkError> {

        do {

            let request = try requestBuilder.build(from: endpoint)

            return session
                .dataTaskPublisher(for: request)

        } catch let error as NetworkError {

            return Fail(error: error)
                .eraseToAnyPublisher()

        } catch {

            return Fail(error: .unknown(error))
                .eraseToAnyPublisher()

        }

    }

}
