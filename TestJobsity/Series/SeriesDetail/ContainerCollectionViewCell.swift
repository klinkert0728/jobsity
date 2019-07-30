//
//  ContainerCollectionViewCell.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit

class ContainerCollectionViewCell: UICollectionViewCell {
    var customContainer: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            guard let customView = customContainer else { return }
            customView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(customView)
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: [], metrics: nil, views: ["view": customView]))
             NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[view]-0-|", options: [], metrics: nil, views: ["view": customView]))
        }
    }
}
