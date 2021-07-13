//
//  MergeRequestsParser.swift
//  Pidgey
//
//  Created by Vyacheslav Khorkov on 13.07.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Alamofire

struct MergeRequest {
    struct Reviewer {
        let username: String
        let approved: Bool
    }
    let id: String
    let title: String
    let path: String
    let url: String
    let reviewers: [Reviewer]
}

// MARK: - Response

struct MergeRequestsResponse: Decodable {
    struct Data: Decodable {
        struct CurrentUser: Decodable {
            struct AuthoredMergeRequests: Decodable {
                struct Node: Decodable {
                    struct Reviewer: Decodable {
                        struct Node: Decodable {
                            let username: String
                        }
                        let nodes: [Node]
                    }
                    struct TargetProject: Decodable {
                        let fullPath: String
                    }
                    let targetProject: TargetProject
                    let iid: String
                    let title: String
                    let webUrl: String
                    let reviewers: Reviewer
                    let approvedBy: Reviewer
                }
                let nodes: [Node]
            }
            let authoredMergeRequests: AuthoredMergeRequests
        }
        let currentUser: CurrentUser
    }
    let data: Data
}

// MARK: - Parser

struct MergeRequestsParser: AlamofireParser {
    typealias Response = MergeRequestsResponse
    typealias Result = [MergeRequest]

    func parse(_ response: Swift.Result<Response, AFError>) -> Swift.Result<[MergeRequest], Error> {
        response
            .mapError { $0 as Error }
            .map {
                $0.data.currentUser.authoredMergeRequests.nodes.map { request in
                    let reviewers = request.reviewers.nodes.map { reviewer in
                        MergeRequest.Reviewer(
                            username: reviewer.username,
                            approved: request.approvedBy.nodes.contains { $0.username == reviewer.username }
                        )
                    }
                    return MergeRequest(id: request.iid,
                                        title: request.title,
                                        path: request.targetProject.fullPath,
                                        url: request.webUrl,
                                        reviewers: reviewers)
                }
            }
    }
}
