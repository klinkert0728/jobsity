//
//  EpisodeDetailTableViewController.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit

class EpisodeDetailTableViewController: BaseTableViewController {

    var viewModel: EpisodeDetailTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        title = viewModel.episode.name
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeDetailTableViewCell.identifier, for: indexPath) as! EpisodeDetailTableViewCell

        cell.viewModel = viewModel.cellViewModel()

        return cell
    }
}
