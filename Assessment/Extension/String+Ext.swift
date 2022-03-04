//
//  String+Ext.swift
//  Assessment
//
//  Created by Arvin Quiliza on 4/3/22.
//

import UIKit

extension String {
    /// return an underlined string
    var underlined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}
