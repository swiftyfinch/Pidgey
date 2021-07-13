//
//  Setup.swift
//  Pidgey
//
//  Created by Vyacheslav Khorkov on 14.07.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import ArgumentParser
import Rainbow

struct Setup: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Setup environment."
    )

    @Option(help: "GitLab endpoint") var gitlab: String?
    @Option(help: "GitLab personal token") var token: String?
    @Option(help: "Slack hook url") var slack: String?

    mutating func run() throws {
        let storage = Storage()

        if gitlab == nil, token == nil, slack == nil {
            print("GitLab endpoint:".yellow, storage.gitlabURL ?? "-".red)
            print("GitLab personal token:".yellow, storage.gitlabToken ?? "-".red)
            print("Slack hook url:".yellow, storage.slackURL ?? "-".red)
            return
        }

        if let gitlab = gitlab { storage.gitlabURL = gitlab }
        if let token = token { storage.gitlabToken = token }
        if let slack = slack { storage.slackURL = slack }
    }
}
