//
//  KeychainService.swift
//  Pidgey
//
//  Created by Vyacheslav Khorkov on 14.07.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import KeychainAccess

final class KeychainService {
    private static let keychain = Keychain(service: "com.pidgey")

    static func string(forKey key: String) -> String? {
        try? keychain.get(key)
    }

    static func set(_ value: String?, forKey key: String) {
        value.map { try? keychain.set($0, key: key) }
    }
}
