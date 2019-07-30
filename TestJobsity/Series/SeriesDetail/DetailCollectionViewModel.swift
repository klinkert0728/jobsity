//
//  DetailCollectionViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

class DetailCollectionViewModel {
    
    private(set) var selectedSerie: Serie
    private var orderedEpisodes: [Int: [Episode]] = [:]
    var currentIndex: IndexPath?
    var displayError: ((_ error: Error) -> ())?
    var shouldReloadData: (() -> ())?
    var didSelect: ((_ episode: Episode) -> ())?
    init(currentSelectedSerie: Serie) {
        selectedSerie = currentSelectedSerie
    }
    
    enum sections {
        case serieMainInfo
        case episodes
    }
    
    private let collectionSections: [sections] = [.serieMainInfo, .episodes]
    
    func getSerieDetail() {
        Serie.getDetail(with: selectedSerie.id) { (result) in
            switch result {
            case .success(let serie):
                self.selectedSerie = serie
                self.shouldReloadData?()
            case .failure(let error):
                self.displayError?(error)
            }
        }
    }
    
    //MARK: Main Info cell
    func createMaininfoCell() -> MainInfoCollectionViewModel {
        return MainInfoCollectionViewModel(summary: selectedSerie.summary, bannerStringUrl: selectedSerie.imageUrl, scheduleInfo: selectedSerie.schedule)
    }
    
    private(set) lazy var episodeCollectionView: EpisodeCollectionViewController = {
        var episodeVc = NavigationHelper.episodesForSerie(series: selectedSerie)
        return episodeVc
    }()
}



extension DetailCollectionViewModel: CollectionViewViewModel {
    var numberOfSectionInCollectionView: Int {
        return collectionSections.count
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return 1
    }
    
    func sectionForItem(at indexPath: IndexPath) -> sections {
        return collectionSections[indexPath.section]
    }
}
