//
//  Endpoint.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation

protocol Endpoint {

    associatedtype Response: Decodable

    var path: String { get }

    var method: HTTPMethod { get }

    var headers: [String: String]? { get }

    var queryItems: [URLQueryItem]? { get }

    var body: Data? { get }

}
