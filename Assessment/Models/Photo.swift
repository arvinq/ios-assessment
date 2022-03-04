//
//  Photo.swift
//  Assessment
//
//  Created by Chamitha Wijesekera on 27/1/22.
//

import Foundation

struct Photo: Codable {
    let author: String
    let url: String
    let downloadUrl: String
}

typealias Photos = [Photo]
