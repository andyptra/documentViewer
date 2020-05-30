//
//  getDataPdfModel.swift
//  privyTest
//
//  Created by andyptra on 5/27/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import Foundation

// MARK: - DataPDF
struct DataPDF: Codable {
    let status: Int
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let file: String?
    let name: String?
}
