//
//  MergeRequestsRequest.swift
//  Pidgey
//
//  Created by Vyacheslav Khorkov on 13.07.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

extension URLRequest {
    private static let query = """
    currentUser {
      authoredMergeRequests(state: opened) {
        nodes {
          webUrl iid title
          targetProject { fullPath }
          reviewers {
            nodes { username }
          }
          approvedBy {
            nodes { username }
          }
        }
      }
    }
    """

    static func mergeRequests(baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let json: [String: Any] = ["query": "query{\(Self.query.flatten())}", "variables": [:]]
        let data = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = data

        return request
    }
}

private extension String {
    func flatten() -> String {
        self.replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
    }
}
