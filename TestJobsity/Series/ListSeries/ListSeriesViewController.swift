//
//  ListSeriresViewController.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit

class ListSeriresViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = ListSeriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.getSeries()
        configureCallBacks()
    }
    
    override func configureApearance() {
        super.configureApearance()
        title = viewModel.title
    }
    
    private func configureCallBacks() {
        viewModel.shouldReloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.displayError = { error in
            print(error)
        }
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: ListCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
    }
}

extension ListSeriresViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSectionInCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
        
        if indexPath.row == viewModel.series.count - 1 {
            viewModel.getOneMorePage()
        }
        cell.viewModel = viewModel.listSeriesViewModel(for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3, height: viewModel.getCellHeigth(for: indexPath.row, bounds: collectionView.bounds.width))
    }
}
