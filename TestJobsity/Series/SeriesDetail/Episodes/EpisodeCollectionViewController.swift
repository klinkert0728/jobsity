//
//  EpisodeCollectionViewController.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit

protocol SelectEpisodeProtocol: class {
    func didSelectEpisode(episode: Episode)
}

class EpisodeCollectionViewController: UICollectionViewController {

    var viewModel: EpisodeCollectionViewModel!
    weak var delegate: SelectEpisodeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        collectionView.register(UINib(nibName: ListCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        title = viewModel.serieName
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberOfSectionInCollectionView
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel.numberOfItems(inSection: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
        
        cell.viewModel = viewModel.listEpisodesViewModel(for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedEpisode = viewModel.selectedEpisode(for: indexPath) else {
            return
        }
        delegate?.didSelectEpisode(episode: selectedEpisode)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? CollectionViewSectionHeader else {
             return UICollectionReusableView()
        }
        
        sectionHeader.title.text = viewModel.titleForSection(section: indexPath.section)
        return sectionHeader
    }
}

extension EpisodeCollectionViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  collectionView.bounds.width / 3, height: 250)
    }
}
