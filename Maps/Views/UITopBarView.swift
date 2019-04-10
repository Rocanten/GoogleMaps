//
//  UITopBarView.swift
//  Maps
//
//  Created by Egor on 06/04/2019.
//  Copyright © 2019 Egor Markov. All rights reserved.
//

import Foundation
import UIKit

class UITopBarView: UIView {
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var createRouteButton: UIButton!
    weak var delegate: TopBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
        createRouteButton.tintColor = UIColor(red: 0.31, green: 0.5, blue: 0.88, alpha: 1.0)
        createRouteButton.addTarget(self, action: #selector(didTapRouteButton), for: .touchUpInside)
    }
    
    func updateLabelDistance(_ distance: String) {
        distanceLabel.text = "Расстояние: \(distance)"
    }
    
    @objc private func didTapRouteButton() {
        delegate?.topBar(didTapRouteButton: createRouteButton)
    }
}
