//
//  getData.swift
//  privyTest
//
//  Created by andyptra on 5/27/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import Foundation

class GetData: Service {
    static let shared =  GetData()
    func getListPdf(completion: @escaping (Data?, Error?) -> Void) {
        let url = baseApiUrl
        get(url) { (result, error) in
            completion(result, error)
        }
    }
}
