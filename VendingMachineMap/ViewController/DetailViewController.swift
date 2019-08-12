//
//  DetailViewController.swift
//  VendingMachineMap
//
//  Created by ice_soi on 2019/07/11.
//  Copyright © 2019年 ice_soi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: BaseViewController{
    
    /** UI */
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblRemark: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    /** クラス変数・定数 */
    var finderInfo: FinderInfo!
    
    /** 初期表示処理 */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIの初期化
        initUI()
        // 位置情報の初期化
        initLocationManager()
        // 地図情報の初期化
        initMapView(mapView)
    }
        
    /** didReceiveMemoryWarning */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** UIの表示内容をを初期化する */
    private func initUI(){
        lblTitle.text = finderInfo.title        // タイトル
        lblDate.text = finderInfo.date          // 日付
        lblRemark.text = finderInfo.remark      // 備考
        lblAddress.text = SEARCHING_MSG         // 住所の初期メッセージ
    }
    
    /** デリゲートメソッド 位置情報取得・更新のたびに呼ぶ */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        updateCurrentPos((locations.last?.coordinate)!,mapView,lblAddress)
    }
    
    /** 画面遷移時のデータ渡し */
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        // 入力画面への遷移の場合、選択した情報を渡す
        if segue.identifier == TO_INPUT{
            let input = segue.destination as! InputViewController
            input.finderInfo = finderInfo
            // 画面登録時のコールバック取得
            input.reloadViewInfoValue = {(reloadInfo: FinderInfo) -> Void in
                // 画面の内容を更新
                self.finderInfo = reloadInfo
                self.lblTitle.text = reloadInfo.title        // タイトル
                self.lblDate.text = reloadInfo.date          // 日付
                self.lblRemark.text = reloadInfo.remark      // 備考
            }
        }
    }
}
