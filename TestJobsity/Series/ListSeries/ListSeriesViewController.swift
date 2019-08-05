//
//  ListSeriresViewController.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListSeriresViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var search: UISearchController!
    
    let viewModel = ListSeriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        collectionView.delegate = self
        collectionView.dataSource = self
        SVProgressHUD.show()
        viewModel.getSeries()
        configureCallBacks()
    }
    
    override func configureApearance() {
        super.configureApearance()
        title = viewModel.title
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Search Series"
        search.searchBar.delegate = self
        
        search.hidesNavigationBarDuringPresentation = false
        search.dimsBackgroundDuringPresentation = true
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.titleView = search.searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.isSearching = false
    }
    
    private func configureCallBacks() {
        viewModel.shouldReloadData = { [weak self] in
            SVProgressHUD.dismiss()
            self?.collectionView.reloadData()
        }
        
        viewModel.displayError = { error in
            SVProgressHUD.showInfo(withStatus: error.localizedDescription)
        }
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: ListCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
    }
    
    private func isSearchBarEmpty() -> Bool {
        return search.searchBar.text?.isEmpty ?? true
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
        
        
        let seriesArray = viewModel.isSearching ? viewModel.filtedSeries : viewModel.series
        
        if indexPath.row == seriesArray.count - 1 && !viewModel.isDownloading && !viewModel.isSearching {
            viewModel.getOneMorePage()
        }
        cell.viewModel = viewModel.listSeriesViewModel(for: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = viewModel.presentSeriesDetail(sected: indexPath.row)
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3, height: viewModel.getCellHeigth(for: indexPath.row, bounds: collectionView.bounds.width))
    }
}

extension ListSeriresViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchSeriesByTest(text: searchController.searchBar.text)
        collectionView.reloadData()
    }
}

extension ListSeriresViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.isSearching = true
        collectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.isSearching = false
        collectionView.reloadData()
    }
}
