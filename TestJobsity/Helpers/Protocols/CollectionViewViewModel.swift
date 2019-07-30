//
//  CollectionViewDataSource.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation

protocol CollectionViewViewModel {
    var numberOfSectionInCollectionView: Int { get }
    func numberOfItems(inSection section: Int) -> Int
}
