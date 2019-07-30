//
//  EpisodeDetailTableViewCell.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit
import AlamofireImage

class EpisodeDetailTableViewCell: UITableViewCell {
    static let identifier = "episodeDetail"
    
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeSummaryLabel: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
    
    
    var viewModel: EpisodeDetailTableViewCellViewModel? {
        didSet {
            refreshUI()
        }
    }
    
    private func refreshUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        episodeNameLabel.text = viewModel.episodeName
        episodeSummaryLabel.attributedText = viewModel.summary
        if let url = viewModel.bannerImage {
            episodeImage.af_setImage(withURL: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            episodeImage.image = UIImage(named: "placeholder")
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        refreshUI()
        // Initialization code
    }
}
