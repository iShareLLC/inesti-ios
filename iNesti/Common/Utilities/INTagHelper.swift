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

let rentRequiredTagsKeys = ["no-cats", "no-dogs", "no-smoking", "need-deposits", "male-only", "female-only"]
let rentRequiredTagsValues = ["无猫", "无狗", "无烟", "有押金", "男生", "女生"]

let roomIncludedTagsKeys = ["wifi", "tv", "washer", "dryer", "central-ac", "shared-bath", "private-bath", "bed-included", "furniture-included"]
let roomIncludedTagsValues = ["WIFI", "电视", "洗衣机", "烘干机", "中央空调", "公用浴室", "单独浴室", "有床", "有家具"]

let buildingSpecsKeys = ["24-hr-doorman", "gym", "pent-garden", "swimming-pool", "study-room", "laundry", "elevator"]
let buildingSpecsValues = ["24小时门卫", "健身室", "屋顶花园", "泳池", "自习室", "洗衣房", "电梯"]

let pathLineKey = ["red-line", "yellow-line", "blue-line", "green-line"]
let pathLineValues = ["红线", "黄线", "蓝线", "绿线"]
