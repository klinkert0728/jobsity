//
//  ListSeriresViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ListSeriesViewModel {
    
    var displayError: ((_ error: Error) -> ())?
    var shouldReloadData: (() -> ())?
    
    private(set) var isDownloading = false
    private(set) var page = 0
    let title = "Series"
    
    private enum Constants {
        static let bannerHeight = 160
        static let buttonsHeight = 35
    }
    
    private(set) var series = [Serie]()
    private var favoriteSeries = [SerieObject]()
    var filtedSeries = [Serie]()
    var isSearching = false
    
    
    /**
     - Parameters:
     - row: The row for the serie.
     - bounds: The bounds of the collectionView
     */
    
    func getCellHeigth(for row: Int, bounds: CGFloat) -> CGFloat {
        var height: CGFloat = 0.0
        if isSearching &&  row >= filtedSeries.count {
            height += CGFloat(Constants.bannerHeight)
            height += CGFloat(Constants.buttonsHeight)
            return height + 40
        } else {
            height = (!isSearching ? series[row] : filtedSeries[row]).name.height(withConstrainedWidth: bounds, font: UIFont.systemFont(ofSize: 14))
            height += CGFloat(Constants.bannerHeight)
            height += CGFloat(Constants.buttonsHeight)
            return height + 40
        }
    }
    
    
    func listSeriesViewModel(for row: Int) -> ListCollectionViewCellViewModel {
        let currentSerie = !isSearching ? series[row] : filtedSeries[row]
        let isFavorite = favoriteSeries.contains(where: { $0.id == currentSerie.id })
        return ListCollectionViewCellViewModel(bannerUrl: currentSerie.imageUrl, rating: currentSerie.rating, name: currentSerie.name, cellType: .serie, isFavorite: isFavorite)
    }
    
    
    /**
     * Get series from API *
     - important: This is the method that is being call when the app needs to reach the API
     * It does not use a parameter, however an page number is sent to determine which page of series
      should the app show *
     */
    
    func getSeries() {
        isDownloading = true
        Serie.getSeries(with: page) { (result) in
            switch result {
            case .success(let series):
                self.series = series
                self.shouldReloadData?()
                self.isDownloading = false
            case .failure(let error):
                self.displayError?(error)
                self.isDownloading = false
            }
        }
    }
    
    func getOneMorePage() {
        page += 1
        getSeries()
    }
    
    //MARK: Detail Series
    
    /// - Parameter row: The selected row index to see series detail.
    func presentSeriesDetail(sected row: Int) -> DetailCollectionViewController {
        let selectedSerie = !isSearching ? series[row] : filtedSeries[row]
        return NavigationHelper.presentSerieDetail(with: selectedSerie)
    }
    
    //MARK: - Search
    
    /// - Parameter text: The text enter by the user to filter serires.
    func searchSeriesByTest(text: String?) {
        guard let searchText = text else {
            return
        }
        filtedSeries.removeAll()
        filtedSeries = series.filter({$0.name.contains(searchText)})
    }
    
    //MARK: Persist Fav series
    
    func save(indexpath row: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let currentSerie = isSearching ? filtedSeries[row] : series[row]
        
        if favoriteSeries.contains(where: { $0.id == currentSerie.id }) {
            deleteFavSerie(serie: currentSerie)
            getFavoriteSeries()
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SerieObject", in: managedContext) else {
            return
        }
        
        let serieObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        serieObject.setValue(currentSerie.name, forKeyPath: "name")
        serieObject.setValue(currentSerie.id, forKeyPath: "id")
        serieObject.setValue(currentSerie.rating, forKeyPath: "rating")
        serieObject.setValue(currentSerie.imageUrl, forKeyPath: "image")
        
        
        do {
            try managedContext.save()
            getFavoriteSeries()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getFavoriteSeries() {
        
        SerieObject.getFavoriteSeries { (result) in
            switch result {
            case .success(let serie):
                self.favoriteSeries = serie
            case .failure(_):
                break
            }
        }
    }
    
    func deleteFavSerie(serie: Serie) {
        guard let serieIndex = favoriteSeries.firstIndex(where: { $0.id == serie.id} ) else {
            return
        }
        let serieToDelete = favoriteSeries[serieIndex]
        serieToDelete.deleteSerie()
    }
}

extension ListSeriesViewModel: CollectionViewViewModel {
    var numberOfSectionInCollectionView: Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return !isSearching ? series.count : filtedSeries.count
    }
}
