//
//  Networking.swift
//  Pidgey
//
//  Created by Vyacheslav Khorkov on 26.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Alamofire
import Foundation

struct Networking {
    let token: String
    let url: URL
    private static let timeout: TimeInterval = 15

    private func patchAuth(_ request: URLRequest) -> URLRequest {
        var request = request
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }

    func load<Parser: AlamofireParser>(request: URLRequest, parser: Parser) -> Result<Parser.Result, Error> {
        var result: Result<Parser.Result, Error>?
        let request = patchAuth(request)
        let semaphore = DispatchSemaphore(value: 0)
        AF.request(request).responseDecodable(of: Parser.Response.self, queue: .global(qos: .utility)) { response in
            result = parser.parse(response.result)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + Self.timeout)
        return result ?? .failure(NetworkingError.parsingFailed)
    }
}

// MARK: - Parser

protocol AlamofireParser {
    associatedtype Response: Decodable
    associatedtype Result
    func parse(_ response: Swift.Result<Response, AFError>) -> Swift.Result<Result, Error>
}

// MARK: - Errors

extension Networking {
    enum NetworkingError: LocalizedError {
        case parsingFailed

        var errorDescription: String? {
            switch self {
            case .parsingFailed:
                return "Can't parse response."
            }
        }
    }
}
