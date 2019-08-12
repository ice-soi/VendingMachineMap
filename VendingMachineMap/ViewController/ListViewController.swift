//
//  ListViewController.swift
//  VendingMachineMap
//
//  Created by ice_soi on 2019/06/30.
//  Copyright © 2019年 ice_soi. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    /** UIコントロール */
    @IBOutlet weak var tableView: UITableView!

    /** 変数 */
    var finderItemList: [FinderInfo] = []       // みつけたものリスト
    var selectItem: FinderInfo!                 // 選択した項目
    
    /** 初期表示用のリスト取得表示 */
    override func viewDidLoad() {
        super.viewDidLoad()
        // リストの初期値設定
        UserDefaultUtil.initList()
    }
    
    /** didReceiveMemoryWarning */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** リストデータのリロード */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    /** リストを取得し表示するセルの個数を指定する */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        finderItemList = UserDefaultUtil.getList()
        return finderItemList.count
    }
    
    /** 表示するセルの内容を設定する処理 */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: LIST_ITEM, for: indexPath)
        // セルに表示する値を設定する
        let finder = finderItemList[indexPath.row]
        cell.textLabel!.text = finder.title
        return cell
    }
    /** セル選択時の処理 */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択解除をして詳細画面へ遷移
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: TO_DETAIL, sender: nil)
    }
    
    /** セル選択時にハイライトされた時の処理 */
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectItem = finderItemList[indexPath.row]
    }

    /** 画面遷移時のデータ渡し */
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        // 遷移先画面に応じた選択項目情報を設定
        switch segue.identifier {
            case TO_DETAIL:
                let detail = segue.destination as! DetailViewController
                detail.finderInfo = selectItem
                break
            case TO_INPUT:
                let input = segue.destination as! InputViewController
                input.finderInfo = FinderInfo()
                break
            default: break
        }
    }
    
    /** 追加ボタン押下時の画面遷移 */
    @objc func barButtonTapped(_ sender: UIBarButtonItem) {
        // 入力画面に遷移
        performSegue(withIdentifier: TO_INPUT, sender: nil)
    }
    
    /** 詳細画面からの画面遷移 */
    @IBAction func backFromDetail(segue: UIStoryboardSegue){
        
    }
    
    /** 入力画面からの画面遷移 */
    @IBAction func backFromInput(segue: UIStoryboardSegue){
        
    }
}

