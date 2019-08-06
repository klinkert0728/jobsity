//
//  FavoriteSerieCollectionViewController.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 8/6/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavoriteSerieCollectionViewController: UICollectionViewController {
    
    var viewModel: FavoriteSerieCollectionViewModel = FavoriteSerieCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        registerCell()
        
    }
    
    func configureAppearance() {
        title = viewModel.title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getFavoriteSeries()
        collectionView.reloadData()
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: ListCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSectionInCollectionView
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel.numberOfItems(inSection: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
        
        
        cell.viewModel = viewModel.listSeriesViewModel(for: indexPath.row)
        cell.selectedFavorite = { [weak self] in
            self?.viewModel.save(indexpath: indexPath.row)
            self?.collectionView.reloadData()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = viewModel.presentSeriesDetail(sected: indexPath.row)
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    

}

extension FavoriteSerieCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3, height: viewModel.getCellHeigth(for: indexPath.row, bounds: collectionView.bounds.width))
    }
}
