//
//  DetailCollectionViewController.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit
import SVProgressHUD

private let containerCell = "containerCell"

class DetailCollectionViewController: UICollectionViewController {
    
    var viewModel: DetailCollectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        collectionView.register(UINib(nibName: MainInfoCollectionViewCell.nib, bundle: nil), forCellWithReuseIdentifier: MainInfoCollectionViewCell.identifier)
        viewModel.getSerieDetail()
        configureCallBacks()
        title = viewModel.selectedSerie.name
    }
    
    private func configureCallBacks() {
        viewModel.shouldReloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.displayError = { error in
            SVProgressHUD.showInfo(withStatus: error.localizedDescription)
            print(error)
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSectionInCollectionView
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var cell: UICollectionViewCell
        let currentSection = viewModel.sectionForItem(at: indexPath)
        switch currentSection {
        case .serieMainInfo:
            let mainInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainInfoCollectionViewCell.identifier, for: indexPath) as! MainInfoCollectionViewCell
            mainInfoCell.viewModel = viewModel.createMaininfoCell()
            cell = mainInfoCell
        case .episodes:
            viewModel.currentIndex = indexPath
            let customContainer = collectionView.dequeueReusableCell(withReuseIdentifier: containerCell, for: indexPath) as! ContainerCollectionViewCell
            if !viewModel.selectedSerie.episodes.isEmpty {
                let episodeVc =  viewModel.episodeCollectionView
                episodeVc.delegate = self
                customContainer.customContainer = episodeVc.view
            }
            
            cell = customContainer
        }
        return cell
    }
    
}

extension DetailCollectionViewController: SelectEpisodeProtocol {
    func didSelectEpisode(episode: Episode) {
        let viewController = NavigationHelper.episodeDetail(episode: episode)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension DetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.sectionForItem(at: indexPath) == .episodes {
            return CGSize(width: collectionView.frame.width, height: 350)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 350)
        }
    }
}
