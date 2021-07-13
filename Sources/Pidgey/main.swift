import ArgumentParser
import Foundation

struct Pidgey: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Notify GitLab reviewers to Slack.",
        version: "1.0.0",
        subcommands: [Notify.self, Setup.self],
        defaultSubcommand: Notify.self
    )
}
Pidgey.main()
