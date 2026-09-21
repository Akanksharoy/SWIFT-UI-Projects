//
//  APIClient.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation
import Combine

protocol APIClient {

    func request<T: Decodable>(
        endpoint: Endpoint
    ) -> AnyPublisher<T, NetworkError>

}
