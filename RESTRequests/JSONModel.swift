//
//  JSONModel.swift
//  RESTRequests
//
//  Created by Леонид on 18.06.2021.
//

import Foundation

struct JsonGetModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
