//
//  Constant.swift
//  Assessment
//
//  Created by Arvin Quiliza on 3/3/22.
//

import UIKit

/// Constant values representing string used in the app
enum Constant {
    static let title       = "Photos"
    static let ok          = "Ok"
    static let attribution = "by"
    static let redirect    = "See full information"
}

/// Constant values that represent s the spaces used in the app
enum Space {
    static let cornerRadius: CGFloat = 5.0
    static let padding: CGFloat      = 8.0
    static let adjacent: CGFloat     = 16.0
}

/// Constant values for representing view sizes in the app
enum Size {
    static let buttonHeight: CGFloat = 40.0
}

/// Constant values to be used for animations
enum Animation {
    static let duration: CGFloat = 0.35
}

/// Easy access values to control the alpha properties for the UIElements in the app
enum Alpha {
    static let none: CGFloat       = 0.0
    static let weakFade: CGFloat   = 0.3
    static let mid: CGFloat        = 0.5
    static let strongFade: CGFloat = 0.8
    static let solid: CGFloat      = 1.0
}

/// Easy access values used for network
enum Network {
    static let baseUrl = "https://picsum.photos/v2/list"
    static let unsplashBaseUrl = "https://unsplash.com/"
}
