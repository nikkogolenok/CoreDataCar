//
//  ViewController.swift
//  CoreDataCar
//
//  Created by Никита Коголенок on 26.01.22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - Variables
    var context: NSManagedObjectContext!
    
    // MARK: - Outlet
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var lastTimeStartedLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var numberOfTripsLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    // MARK: - Actions
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
    }
    
    @IBAction func startEngineAction(_ sender: UIButton) {
    }
    
    @IBAction func rateAction(_ sender: UIButton) {
    }
}

