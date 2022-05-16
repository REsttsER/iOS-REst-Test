//
//  modeButton.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/05/16.
//

import UIKit

class modeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = .black
        self.alpha = 0.4
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
}
