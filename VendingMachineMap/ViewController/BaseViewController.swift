//
//  BaseViewController.swift
//  VendingMachineMap
//
//  Created by ice_soi on 2019/08/04.
//  Copyright © 2019年 ice_soi. All rights reserved.
//


import MapKit
import CoreLocation
import Foundation

class BaseViewController: UIViewController,CLLocationManagerDelegate{
    
    /** 共通定数 */
    let SEARCHING_MSG = "住所を取得しています..."      // 初回住所取得時のメッセージ
    let NOT_FOUND_MSG = "住所が取得できませんでした"    // 住所情報更新失敗時のメッセージ
    let TO_LIST = "toList"                         // 一覧リスト画面遷移Key
    let TO_INPUT = "toInput"                       // 入力画面遷移Key
    let TO_DETAIL = "toDetail"                     // 詳細画面遷移Key
    let TO_DETAIL_BACK = "toDetailBack"            // 詳細画面に戻る遷移Key
    let LIST_ITEM = "item"                         // リスト項目
    
    /** メンバ変数 */
    var locationMgr: CLLocationManager!
    
    /** 位置情報の初期化処理 */
    func initLocationManager(){
        locationMgr = CLLocationManager()
        locationMgr.delegate = self
        // 位置情報の使用の許可を得る
        locationMgr.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                // 座標の表示
                locationMgr.startUpdatingLocation()
                break
            default:
                break
            }
        }
    }

    /** 地図情報の初期化処理 */
    func initMapView(_ mapView: MKMapView){
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)
        
        // 現在位置表示の有効化
        mapView.showsUserLocation = true
        // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
        mapView.userTrackingMode = .follow
    }
    
    /** 位置情報を持っている場合の初期化処理 */
    func initMapView(_ mapView: MKMapView,_ latitude: Double, _ longitude: Double){
        // 緯度・経度を設定
        let location:CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(latitude,longitude)
        mapView.setCenter(location,animated:true)
        
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)
        
        // 現在位置表示の有効化
        mapView.showsUserLocation = true
        // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
        mapView.userTrackingMode = .follow
    }

    /** 地図の中心位置の更新して更新した住所を取得 */
    func updateCurrentPos(_ coordinate:CLLocationCoordinate2D,_ mapView:MKMapView, _ lblAddress:UILabel) {
        var region:MKCoordinateRegion = mapView.region
        region.center = coordinate
        mapView.setRegion(region,animated:true)
        
        // 住所を取得し返却する。取得できなかった場合はメッセージを返却
        lblAddress.text = NOT_FOUND_MSG
        let location = CLLocation(latitude: mapView.region.center.latitude, longitude: mapView.region.center.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard
                let placemark = placemarks?.first, error == nil,
                let administrativeArea = placemark.administrativeArea,  // 都道府県
                let locality = placemark.locality,                      // 市区町村
                let thoroughfare = placemark.thoroughfare,              // 地名(丁目)
                let subThoroughfare = placemark.subThoroughfare         // 番地
                else {
                    return
            }
            lblAddress.text = "\(administrativeArea)\(locality)\(thoroughfare)\(subThoroughfare)"
            lblAddress.numberOfLines = 0                               //折り返し
            lblAddress.lineBreakMode = NSLineBreakMode.byCharWrapping  //文字で改行
            lblAddress.sizeToFit()                                     //サイズを文字列に合わせる
        }
    }
    
}
