//
//  Slack.swift
//  Pidgey
//
//  Created by Vyacheslav Khorkov on 13.07.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Alamofire
import Foundation

struct Slack {
    let url: URL
    private let timeout: TimeInterval = 15
    private let iconEmoji = ":approve:"

    func notifySlack(mergeRequest: MergeRequest) {
        print("\nNotify:".green)
        let reviewersWithoutApprove = mergeRequest.reviewers.filter { !$0.approved }
        reviewersWithoutApprove.forEach {
            let result = notifyUser(username: $0.username, mergeRequest: mergeRequest)
            print("- \($0.username):", result)
        }
    }

    private func notifyUser(username: String, mergeRequest: MergeRequest) -> String {
        var result: String?
        let json: [String: Any] = [
            "channel": "@\(username)",
            "username": "GitLab Review",
            "icon_emoji": iconEmoji,
            "blocks": [
                [
                    "type": "section",
                    "text": [
                        "type": "mrkdwn",
                        "text": """
                        Please, *review* the merge request to *\(mergeRequest.path)*:
                        <\(mergeRequest.url)|*!\(mergeRequest.id) \(mergeRequest.title)*>
                        """
                    ]
                ]
            ]
        ]

        let semaphore = DispatchSemaphore(value: 0)
        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding()).response(
            queue: .global(qos: .utility),
            responseSerializer: DataResponseSerializer()
        ) { response in
            switch response.result {
            case .success(let data):
                result = String(data: data, encoding: .utf8)?.green
            case .failure(let error):
                result = error.localizedDescription.red
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + timeout)
        return result ?? "Unknow".yellow
    }
}
