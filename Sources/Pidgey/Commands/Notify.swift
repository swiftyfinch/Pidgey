//
//  Notify.swift
//  Pidgey
//
//  Created by Vyacheslav Khorkov on 14.07.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import ArgumentParser
import Foundation

struct Notify: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: """
        Show list of your GitLab merge requests and select one for notify reviewers to Slack.
        """
    )

    func run() throws {
        let (gitlabToken, gitlabURL, slackURL) = try environment()
        let gitlab = Networking(token: gitlabToken, url: gitlabURL)
        switch gitlab.loadMergeRequests() {
        case .success(let mergeRequests):
            guard mergeRequests.count > 0 else {
                return print("You haven't any merge requests".yellow)
            }

            mergeRequests.enumerated().forEach { index, value in
                print("\(index))", "!\(value.id)".green, value.title.green, "(\(value.path))")
                value.reviewers.forEach {
                    print("  ", $0.approved ? "✓".green : "-".red, $0.username)
                }
            }

            print("\nSelect merge requests by id (0-\(mergeRequests.count - 1)):".yellow)
            if let index = readLine().flatMap(Int.init), mergeRequests.indices ~= index {
                Slack(url: slackURL).notifySlack(mergeRequest: mergeRequests[index])
            } else {
                print("Incorrect input".red)
            }
        case .failure(let error):
            print(error.localizedDescription.red)
        }
    }

    // Collect environment or suggest to provide more info.
    private func environment() throws -> (gitlabToken: String, gitlabURL: URL, slackURL: URL) {
        let storage = Storage()
        guard let gitlabToken = storage.gitlabToken,
              let gitlabURL = storage.gitlabURL.flatMap(URL.init(string:)),
              let slackURL = storage.slackURL.flatMap(URL.init(string:))
        else { throw NotifyError.missedEnvironment }
        return (gitlabToken, gitlabURL, slackURL)
    }
}

// MARK: - Errors

extension Notify {
    enum NotifyError: LocalizedError {
        case missedEnvironment

        var errorDescription: String? {
            switch self {
            case .missedEnvironment:
                return "Some tokens are missed. Use the setup command to add them."
            }
        }
    }
}
