//
//  ListSeriresViewModel.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import UIKit

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
    
    private(set) var series = [Series]()
    
    func getCellHeigth(for row: Int, bounds: CGFloat) -> CGFloat {
        var height = series[row].name.height(withConstrainedWidth: bounds, font: UIFont.systemFont(ofSize: 14))
        height += CGFloat(Constants.bannerHeight)
        height += CGFloat(Constants.buttonsHeight)
        return height + 40
    }
    
    func listSeriesViewModel(for row: Int) -> ListCollectionViewCellViewModel {
        let currentSerie = series[row]
        return ListCollectionViewCellViewModel(bannerUrl: currentSerie.imageUrl, rating: currentSerie.rating, name: currentSerie.name)
    }
    
    func getSeries() {
        isDownloading = true
        Series.getSeries(with: page) { (result) in
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
}

extension ListSeriesViewModel: CollectionViewViewModel {
    var numberOfSectionInCollectionView: Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return series.count
    }
}
