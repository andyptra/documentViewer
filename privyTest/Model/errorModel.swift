
//
//  errorModel.swift
//  privyTest
//
//  Created by andyptra on 5/27/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import Foundation

// MARK: - Status
struct ErrorRequestModel : Codable {
    let errorCode: String?
    enum CodingKeys: String, CodingKey {
        case errorCode = "status"
    }
}
