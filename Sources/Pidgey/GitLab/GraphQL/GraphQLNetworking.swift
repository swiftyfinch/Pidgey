//
//  GraphQLNetworking.swift
//  Pidgey
//
//  Created by Vyacheslav Khorkov on 13.07.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

extension Networking {
    func loadMergeRequests() -> Result<MergeRequestsParser.Result, Error> {
        load(request: .mergeRequests(baseURL: url), parser: MergeRequestsParser())
    }
}
