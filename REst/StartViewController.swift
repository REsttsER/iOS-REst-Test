//
//  StartViewController.swift
//  REst
//
//  Created by eunae on 2022/05/11.
//

import UIKit
import CoreLocation
import MapKit
import RealmSwift

class StartViewController: ViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var restButton: modeButton!
    @IBOutlet weak var jogButton: modeButton!
    @IBOutlet weak var runButton: modeButton!
    @IBOutlet weak var accountButton: UIButton!
    
    var trackData: TrackData = TrackData()
    
    // locationManager 생성
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation() // startUpdate를 해야 didUpdateLocation 메소드가 호출됨
        manager.delegate = self
        return manager
    }()
    
    var previousCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocationUsagePermission()
        
        // xcode 종료 후 어플을 다시 실행했을 때 뜨는 오류 방지.
        self.mapView.mapType = MKMapType.standard
        // 지도에 내 위치 표시
        self.mapView.showsUserLocation = true
        // 현재 내 위치 기준으로 지도를 움직임
        self.mapView.setUserTrackingMode(.follow, animated: true)
        
        self.mapView.isZoomEnabled = true
        
        restButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        jogButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        runButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        accountButton.titleLabel?.text = ""
        
        self.mapView.delegate = self
    }
    
    // view가 화면에서 사라질 때 locationManager가 위치 업데이트를 중단하도록 하기
    override func viewWillDisappear(_ animated: Bool) {
        self.locationManager.stopUpdatingLocation()
    }
    
    // locationManager를 통해 gps 사용 허가 받기
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func restButton(_ sender: UIButton) {
    }
    
    
    @IBAction func joggingButton(_ sender: UIButton) {
    }
    
    
    @IBAction func runningButton(_ sender: UIButton) {
    }
    
    @IBAction func accountButton(_ sender: UIButton) {
    }
}

extension StartViewController: CLLocationManagerDelegate {
    // GPS 권한 설정 여부에 따른 로직 처리
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            DispatchQueue.main.async {
                self.getLocationUsagePermission()
            }
        case .denied:
            print("GPS 권한 요청 거부됨")
            DispatchQueue.main.async {
                self.getLocationUsagePermission()
            }
        default:
            print("GPS: Default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last
        else { return }
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        
        if let previousCoordinate = self.previousCoordinate {
            var points: [CLLocationCoordinate2D] = []
            let point1 = CLLocationCoordinate2DMake(previousCoordinate.latitude, previousCoordinate.longitude)
            let point2 = CLLocationCoordinate2DMake(latitude, longtitude)
            points.append(point1)
            points.append(point2)
            
            let lineDraw = MKPolyline(coordinates: points, count: points.count)
            self.mapView.addOverlay(lineDraw) // 를 하면 func mapView(...rendererFor overlay: MKOverlay...) -> MKOverlayRenderer 함수가 호출됨.
        }
    }
}

extension StartViewController: MKMapViewDelegate {
    // polyline 객체가 들어왔을 때 그것을 그리는 메서드
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline
        else {
            print("can't draw polyline")
            return MKOverlayRenderer()
        }
        
        let renderer = MKPolylineRenderer(polyline: polyLine)
        renderer.strokeColor = .orange
        renderer.lineWidth = 5.0
        renderer.alpha = 1.0
        return renderer
    }
}
