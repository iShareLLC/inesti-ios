//
//  PopularPlace.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/17/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation
import RxDataSources

struct PopularPlace: Codable {
    let price: String
    let title1: String
    let title2: String
    let description: String
    let imageUrls: [String]

    var area: String {
        return title1
    }

    var title: String {
        return title2
    }

    var attributedTitle: NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.maximumLineHeight = 29
        paragraph.lineBreakMode = .byWordWrapping
        return NSAttributedString(string: title2, attributes: [NSAttributedStringKey.paragraphStyle: paragraph])
    }

    var summary: String {
        return description
    }
}

struct SectionOfPopularPlace {
    var header: String
    var items: [Item]
}

extension SectionOfPopularPlace: SectionModelType {
    typealias Item = PopularPlace

    public init(original: SectionOfPopularPlace, items: [PopularPlace]) {
        self = original
        self.items = items
    }
}

