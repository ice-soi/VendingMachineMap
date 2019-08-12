//
//  InputViewController.swift
//  VendingMachineMap
//
//  Created by ice_soi on 2019/07/15.
//  Copyright © 2019年 ice_soi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class InputViewController: BaseViewController{
    
    /** UI */
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtRemark: UITextField!
    
    /** クラス変数・定数 */
    var finderInfo: FinderInfo!
    
    /** クロージャー */
    var reloadViewInfoValue: ((FinderInfo) -> Void)?
    
    /**
     UIAction
     */
    /** タイトル入力時の処理 */
    @IBAction func inputTitle(_ sender: UITextField) {
        txtTitle.text = sender.text
    }
    /** 備考入力時の処理 */
    @IBAction func inputRemark(_ sender: UITextField) {
        txtRemark.text = sender.text
    }
    /** 削除ボタン押下時の処理 */
    @IBAction func deleteButtonTouchDown(_ sender: Any) {
        // 現在の内容を削除してリスト画面に遷移する
        UserDefaultUtil.remove(finderInfo)
        // リスト画面に遷移する
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    /** 登録ボタン押下時の処理 */
    @IBAction func ButtonTouchDown(_ sender: Any) {

        let location = locationMgr.location!
        finderInfo.title = txtTitle.text!
        finderInfo.remark = txtRemark.text!
        finderInfo.latitude = location.coordinate.latitude
        finderInfo.longitude = location.coordinate.longitude
        
        // リストに追加して保存する
        let list = UserDefaultUtil.append(finderInfo)
        UserDefaultUtil.save(list)
        
        // 詳細画面再表示用の値をクロージャーに設定
        reloadViewInfoValue?(finderInfo)
        // リスト画面に遷移する
        self.dismiss(animated: true, completion: nil)
    }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /** UIの表示内容をを初期化する */
    private func initUI(){
        txtTitle.text = finderInfo.title        // タイトル
        txtRemark.text = finderInfo.remark      // 備考
        lblAddress.text = SEARCHING_MSG         // 住所の初期メッセージ
    }
    
    /** デリゲートメソッド 位置情報取得・更新のたびに呼ぶ */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        updateCurrentPos((locations.last?.coordinate)!,mapView,lblAddress)
    }
    
    /** 画面遷移時のデータ渡し */
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
    }
}


