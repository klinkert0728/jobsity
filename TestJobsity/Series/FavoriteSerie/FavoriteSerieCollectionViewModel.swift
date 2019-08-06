//
//  FavoriteSerieCollectionViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 8/6/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct FavoriteSerieCollectionViewModel {
    
    private enum Constants {
        static let bannerHeight = 160
        static let buttonsHeight = 35
    }
    
    private(set) var favoriteSeries = [SerieObject]()
    let title = "Favorite Series"
    
    /**
     - Parameters:
     - row: The row for the serie.
     - bounds: The bounds of the collectionView
     */
    
    func getCellHeigth(for row: Int, bounds: CGFloat) -> CGFloat {
        var height: CGFloat = 0.0
        
        height += CGFloat(Constants.bannerHeight)
        height += CGFloat(Constants.buttonsHeight)
        height += favoriteSeries[row].name!.height(withConstrainedWidth: bounds, font: UIFont.systemFont(ofSize: 14))
        return height + 40
    }
    
    func listSeriesViewModel(for row: Int) -> ListCollectionViewCellViewModel? {
        let currentSerie = favoriteSeries[row]
        let isFavorite = favoriteSeries.filter({$0.id == currentSerie.id}).first != nil ? true : false
        
        guard let name = currentSerie.name, let bannerUrl = currentSerie.image else {
            return nil
        }
        
        return ListCollectionViewCellViewModel(bannerUrl: bannerUrl, rating: currentSerie.rating, name: name, cellType: .serie, isFavorite: isFavorite)
    }
    
    func presentSeriesDetail(sected row: Int) -> DetailCollectionViewController {
        let selectedSerie = favoriteSeries[row]
        
        let serie = Serie(currentId: Int(selectedSerie.id))
        return NavigationHelper.presentSerieDetail(with: serie)
    }
    
    //MARK: Persist Fav series
    
    mutating func save(indexpath row: Int) {
        
        let currentSerie = favoriteSeries[row]
        
        if favoriteSeries.contains(where: { $0.id == currentSerie.id }) {
            deleteFavSerie(serie: currentSerie)
            getFavoriteSeries()
            return
        }
        
        currentSerie.save { (success) in
            if success {
                getFavoriteSeries()
            }
        }
    }
    
    mutating func getFavoriteSeries() {
        
        SerieObject.getFavoriteSeries { (result) in
            switch result {
            case .success(let series):
                favoriteSeries = series.sorted(by: { (first, second) in
                    guard let firstName = first.name, let secondName = second.name else {
                        return false
                    }
                    return firstName < secondName
                })
            case .failure(_):
                break
            }
        }
    }
    
    private func deleteFavSerie(serie: SerieObject) {
        serie.deleteSerie()
    }
}

extension FavoriteSerieCollectionViewModel: CollectionViewViewModel {
    var numberOfSectionInCollectionView: Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return favoriteSeries.count
    }
}

