//
//  ActiveListViewController.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/05/16.
//

import UIKit
import RealmSwift

class ActiveListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // Trace들을 DB로부터 Read하여 담을 변수
    var trackDatas: Results<TrackData>!
    // Trace 업데이트시 자동으로 테이블뷰 reload하는 데 쓸 변수
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmHelper.shared.realm
        self.trackDatas = realm.objects(TrackData.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        notificationToken = trackDatas.observe { changes in
            self.tableView.reloadData()
        }
    }
}

extension ActiveListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "activeInfoTableViewCell") as? ActiveInfoTableViewCell
        else { return UITableViewCell() }
        
        let trackData = self.trackDatas[indexPath.row]
        cell.labelDate?.text = trackData.formattedDate() + "의 기록"
        return cell
    }
}

extension ActiveListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trackData = self.trackDatas[indexPath.row]
        let traces: List<Trace> = trackData.traces
        
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let nextViewController = mainStoryBoard.instantiateViewController(withIdentifier: "showActiveViewContoller") as! ShowActiveViewController
        
        nextViewController.traces = traces
        _ = nextViewController.view
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let trackData = trackDatas[indexPath.row]
        RealmHelper.shared.delete(trackData)
    }
}
