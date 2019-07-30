//
//  EpisodeCollectionViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

class EpisodeCollectionViewModel {
    let episodes: [Episode]
    let serieName: String
    private var orderedEpisodes: [Int: [Episode]] = [:]
    
    init(episodes: [Episode], name: String) {
        serieName = name
        self.episodes = episodes
        orderEpisodesBySeason()
    }
    
    func listEpisodesViewModel(for indexPath: IndexPath) -> ListEpisodesViewModel? {
        
        guard let currentEpisode = orderedEpisodes[indexPath.section + 1]?[indexPath.row] else {
            return nil
        }
        
        return ListEpisodesViewModel(bannerUrl: currentEpisode.image, name: currentEpisode.name, cellType: .episode, season: currentEpisode.season, number: currentEpisode.number)
    }
    
    func orderEpisodesBySeason() {
        for episode in episodes {
            guard var currentArray = orderedEpisodes[episode.season] else {
                orderedEpisodes[episode.season] = [episode]
                continue
            }
            currentArray.append(episode)
            orderedEpisodes[episode.season] = currentArray
        }
    }
    
    
    func selectedEpisode(for indexPath: IndexPath) -> Episode? {
        guard let selected = orderedEpisodes[indexPath.section + 1]?[indexPath.row] else {
            return nil
        }
        
        return selected
    }
}


extension EpisodeCollectionViewModel: CollectionViewViewModel {
    var numberOfSectionInCollectionView: Int {
        return orderedEpisodes.count
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return orderedEpisodes[section + 1]?.count ?? 0
    }
    
    func titleForSection(section: Int) -> String {
        guard let _ = orderedEpisodes[section + 1] else {
            return "Season undefined"
        }
        return "Season \(section + 1)"
    }
}
