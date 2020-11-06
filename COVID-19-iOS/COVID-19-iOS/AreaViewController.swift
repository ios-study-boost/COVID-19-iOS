//
//  AreaViewController.swift
//  COVID-19-iOS
//
//  Created by Eunjee Shin on 2020/11/05.
//

import UIKit

class AreaViewController: UIViewController {
    
    
    @IBOutlet weak var segmentCtrl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    static func viewController() -> AreaViewController {
        return UIStoryboard.init(name: "SearchResult", bundle: nil).instantiateViewController(withIdentifier: "Area") as! AreaViewController
    }
    
    private lazy var mapViewController: MapViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "SearchResult", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "MapView") as! MapViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var tableViewController: TableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "SearchResult", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "TableView") as! TableViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    private func updateView() {
        if segmentCtrl.selectedSegmentIndex == 0 {
            remove(asChildViewController: tableViewController)
            add(asChildViewController: mapViewController)
        } else {
            remove(asChildViewController: mapViewController)
            add(asChildViewController: tableViewController)
        }
    }

}
