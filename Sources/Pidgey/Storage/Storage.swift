//
//  Storage.swift
//  Pidgey
//
//  Created by Vyacheslav Khorkov on 14.07.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

private extension String {
    static let gitlabURL = "gitlabURL"
    static let gitlabToken = "gitlabToken"
    static let slackURL = "slackURL"
}

final class Storage {
    var gitlabURL: String? {
        get { UserDefaults.standard.string(forKey: .gitlabURL) }
        set { UserDefaults.standard.set(newValue, forKey: .gitlabURL) }
    }
    var gitlabToken: String? {
        get { KeychainService.string(forKey: .gitlabToken) }
        set { KeychainService.set(newValue, forKey: .gitlabToken) }
    }
    var slackURL: String? {
        get { KeychainService.string(forKey: .slackURL) }
        set { KeychainService.set(newValue, forKey: .slackURL) }
    }
}
