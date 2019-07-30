//
//  NavigationHelper.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import UIKit
struct NavigationHelper {
    private enum Constants {
        enum storyboardsName {
            static let main = "Main"
        }
        
        enum controllersIndentifiers {
            static let seriesDetail = "DetailCollectionViewController"
            static let episodes = "EpisodeCollectionViewController"
            static let episodeDetail = "EpisodeDetailTableViewController"
        }
    }
    
    static func presentSerieDetail(with selectedSerie: Serie) -> DetailCollectionViewController {
        let detailVC =  UIStoryboard(name: Constants.storyboardsName.main, bundle: nil).instantiateViewController(withIdentifier: Constants.controllersIndentifiers.seriesDetail) as! DetailCollectionViewController
        let viewModel = DetailCollectionViewModel(currentSelectedSerie: selectedSerie)
        
        detailVC.viewModel = viewModel
        return detailVC
    }
    
    static func episodesForSerie(series: Serie) -> EpisodeCollectionViewController {
        let episodesVc =  UIStoryboard(name: Constants.storyboardsName.main, bundle: nil).instantiateViewController(withIdentifier: Constants.controllersIndentifiers.episodes) as! EpisodeCollectionViewController
        let viewModel = EpisodeCollectionViewModel(episodes: series.episodes, name: series.name)
        episodesVc.viewModel = viewModel
        return episodesVc
    }
    
    static func episodeDetail(episode: Episode) -> EpisodeDetailTableViewController {
        let episodesDetailVc =  UIStoryboard(name: Constants.storyboardsName.main, bundle: nil).instantiateViewController(withIdentifier: Constants.controllersIndentifiers.episodeDetail) as! EpisodeDetailTableViewController
        let viewModel = EpisodeDetailTableViewModel(episode: episode)
        episodesDetailVc.viewModel = viewModel
        return episodesDetailVc
    }
}
