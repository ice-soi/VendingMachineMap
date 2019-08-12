//
//  FinderInfo.swift
//  VendingMachineMap
//
//  Created by ice_soi on 2019/07/14.
//  Copyright © 2019年 ice_soi. All rights reserved.
//

import Foundation

class  FinderInfo: NSObject ,NSCoding{
    
    /** 定数 */
    private let ID = "id"                   // ID
    private let TITLE = "title"             // タイトル
    private let REMARK = "remark"           // 備考
    private let LATITUDE = "latitude"       // 緯度
    private let LONGITUDE = "longitude"     // 経度
    private let DATE = "date"               // 日付
    
    /** メンバ */
    var id: String         // ID
    var title: String      // タイトル
    var remark: String     // 備考
    var latitude: Double   // 緯度
    var longitude: Double  // 経度
    var date: String       // 日付
    
    /** イニシャライザ */
    override init(){
        self.id = UUID().uuidString
        self.title = ""
        self.remark = ""
        self.latitude = 0.0
        self.longitude = 0.0
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        self.date = formatter.string(from: Date())
    }
    
    /** イニシャライザ */
    init(_ title:String,_ remark:String,_ latitude:Double,_ longitude:Double){
        self.id = UUID().uuidString
        self.title = title
        self.remark = remark
        self.latitude = latitude
        self.longitude = longitude
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        self.date = formatter.string(from: Date())
    }

    /** エンコード */
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: ID)
        aCoder.encode(self.title, forKey: TITLE)
        aCoder.encode(self.remark, forKey: REMARK)
        aCoder.encode(self.latitude, forKey: LATITUDE)
        aCoder.encode(self.longitude, forKey: LONGITUDE)
        aCoder.encode(self.date, forKey: DATE)
    }
    
    /** デコード */
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: ID) as! String
        self.title = aDecoder.decodeObject(forKey: TITLE) as! String
        self.remark = aDecoder.decodeObject(forKey: REMARK) as! String
        self.latitude = aDecoder.decodeDouble(forKey: LATITUDE)
        self.longitude = aDecoder.decodeDouble(forKey: LONGITUDE)
        self.date = aDecoder.decodeObject(forKey: DATE) as! String
    }
    
}
