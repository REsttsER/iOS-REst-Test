//
//  TrackData.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/05/16.
//

import Foundation
import RealmSwift

class TrackData: Object {
    @objc dynamic var date: Date? = nil
    let traces = List<Trace>()
    
    convenience init (date: Date?) {
        self.init()
        self.date = date
    }
    
    func appendTrace(trace: Trace) {
        self.traces.append(trace)
    }
    
    func formattedDate() -> String {
        guard let date = self.date
        else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
}
