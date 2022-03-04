//
//  PhotoViewModel.swift
//  Assessment
//
//  Created by Chamitha Wijesekera on 27/1/22.
//

import Foundation

struct PhotoViewModel {
    let author: String
    let url: String
    let downloadUrl: String
    
    init(photo: Photo) {
        self.author = photo.author
        self.url = photo.url
        self.downloadUrl = photo.downloadUrl
    }
}
