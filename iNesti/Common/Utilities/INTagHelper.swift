//
//  INTagHelper.swift
//  iNesti
//
//  Created by Zian Chen on 5/22/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class INTagHelper: NSObject {
    
    var locations = [INLocation]()
    
    static let shared = INTagHelper()
    
    func loadJSON() {
        if let path = Bundle.main.path(forResource: "location", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                self.locations = try jsonDecoder.decode([INLocation].self, from: data)
            } catch {
                // handle error
                DLog("JSON Decoding Error!")
            }
        }
    }
}

let rentIncludedTagsKeys = ["eletric", "water", "internet", "heat", "gas", "public"]
let rentIncludedTagsValues = ["电费", "水费", "网费", "暖气费", "燃气费", "公共设施费"]

let rentRequiredTagsKeys = ["no-cat", "no-dog", "no-smoke", "reserve", "man-only", "woman-only"]
let rentRequiredTagsValues = ["无猫", "无狗", "无烟", "有押金", "男生", "女生"]

let roomIncludedTagsKeys = ["wifi", "television", "washer", "dryer", "central-ac", "share-bath", "single-bath", "has-bed", "has-furniture"]
let roomIncludedTagsValues = ["WIFI", "电视", "洗衣机", "烘干机", "中央空调", "公用浴室", "单独浴室", "有床", "有家具"]

let buildingSpecsKeys = ["24-hr-doorman", "gym", "pent-garden", "swimming-pool", "study-room", "laundry", "elevator"]
let buildingSpecsValues = ["24小时门卫", "健身室", "屋顶花园", "泳池", "自习室", "洗衣房", "电梯"]

/*
 let rentIncluded = ["电费": "eletric",
 "水费": "water",
 "网费": "internet",
 "暖气费": "heat",
 "燃气费": "gas",
 "公共设施费": "public"]
 
 let rentRequired = ["无猫": "no-cat",
 "无狗": "no-dog",
 "无烟": "no-smoke",
 "有押金": "reserve",
 "男生": "man-only",
 "女生": "woman-only"]
 
 let roomIncluded = ["WIFI": "wifi",
 "电视": "television",
 "洗衣机": "washer",
 "烘干机": "dryer",
 "中央空调": "central-ac",
 "公用浴室": "share-bath",
 "单独浴室": "single-bath",
 "有床": "has-bed",
 "有家具": "has-furniture"]
 */
