//
//  UserDefaultUtil.swift
//  VendingMachineMap
//
//  Created by ice_soi on 2019/07/31.
//  Copyright © 2019年 ice_soi. All rights reserved.
//

import Foundation
enum UserDefaultUtil {

    /** リストkey */
    static let ITEM_LIST = "itemList"
    
    /** 表示用リストの初期化*/
    static func initList(){
        UserDefaults.standard.register(defaults: [ITEM_LIST :  [FinderInfo]()])
    }
    
    /** 表示用リストの取得 */
    static func getList() -> [FinderInfo]{
        // UserDefaultから設定されている値を返却、設定されていない場合は空の配列を返却
        if let list = UserDefaults().object(forKey: ITEM_LIST) as? Data{
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(list) as? [FinderInfo]{
                return unarchivedObject
            }
        }
        return [FinderInfo]()
    }
    
    /** リストの保存 */
    static func save(_ value: [FinderInfo]){
        let list = try! NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        UserDefaults.standard.set(list, forKey: ITEM_LIST)
    }

    /** 現在保存されているリストの最後に追加 */
    static func append(_ value: FinderInfo) -> [FinderInfo]{
        // リストを取得し最後尾に引数の要素を追加
        var list = getList()
        list = list.filter({$0.id != value.id})
        list.append(value)
        return list
    }
    
    /** 現在保存されているリストから引数の要素を削除 */
    static func remove(_ value: FinderInfo){
        // リストを取得し引数の要素を除外して保存
        var list = getList()
        list = list.filter({$0.id != value.id})
        save(list)
    }
    
    /** 現在保存されているリストを削除する */
    static func clear(){
        UserDefaults.standard.removeObject(forKey: ITEM_LIST)
    }
    
    /** UserDefaultに保存されている内容を全て削除 */
    static func allClear(){
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
        }
    }

}
