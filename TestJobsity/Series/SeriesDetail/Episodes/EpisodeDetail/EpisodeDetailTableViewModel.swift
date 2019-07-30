//
//  EpisodeDetailTableViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

struct EpisodeDetailTableViewModel {
    let episode: Episode
    
    
    func cellViewModel() -> EpisodeDetailTableViewCellViewModel {
        return EpisodeDetailTableViewCellViewModel(episode: episode)
    }
}

extension EpisodeDetailTableViewModel: CollectionViewViewModel {
    var numberOfSectionInCollectionView: Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return 1
    }
}
