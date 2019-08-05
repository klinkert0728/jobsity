//
//  BaseViewController.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 7/29/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureApearance()
        // Do any additional setup after loading the view.
    }
    

    /// Base configure appearance for ViewController
    func configureApearance() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
