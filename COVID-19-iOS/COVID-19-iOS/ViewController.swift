//
//  ViewController.swift
//  COVID-19-iOS
//
//  Created by Eunjee Shin on 2020/10/19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tempTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempTableView.delegate = self
        tempTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tempTableView.dequeueReusableCell(withIdentifier: "TempCell", for: indexPath)
        
        return cell
    }


}

