//
//  DomesticViewController.swift
//  COVID-19-iOS
//
//  Created by In Taek Cho on 2020-11-08.
//

import UIKit

class DomesticViewController: UIViewController {

    @IBOutlet weak var domesticTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DomesticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension DomesticViewController: UITableViewDataSource {

}
