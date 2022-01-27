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
    var car: Car?
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        return dateFormatter
    }()
    
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
        
        getDataFromFile()
    }
    
    // MARK: - Methods
    private func updateSegmentedControl() {
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        if let mark = segmentedControl.titleForSegment(at: 0) {
            fetchRequest.predicate = NSPredicate(format: "mark == %@", mark)
            
            do {
                let results = try context.fetch(fetchRequest)
                car = results[0]
                guard let selectedCar = car else { return }
                inserdDataFrom(selectedCar: selectedCar)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func inserdDataFrom(selectedCar car: Car) {
        self.car = car
        carImageView.image = UIImage(data: car.imageData!)
        markLabel.text = car.mark
        modelLabel.text = car.model
        ratingLabel.text = "Rating: \(car.rating) / 10"
        numberOfTripsLabel.text = "Number of Trips \(car.timesDriven)"
        lastTimeStartedLabel.text = "Last: \(dateFormatter.string(from: car.lastStarted!))"
        segmentedControl.backgroundColor = car.tintColor as? UIColor
    }
    
    private func getDataFromFile() {
        
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mark != nil")
        
        var records = 0
        
        do {
            records = try context.count(for: fetchRequest)
            print("Is Date there already?")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
              let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        
        for dictionary in dataArray {
            let entity = NSEntityDescription.entity(forEntityName: "Car", in: context)
            let car = NSManagedObject(entity: entity!, insertInto: context) as! Car
            
            let carDictionary = dictionary as! [String : AnyObject]
            car.mark = carDictionary["mark"] as? String
            car.model = carDictionary["model"] as? String
            car.rating = carDictionary["rating"] as! Double
            car.lastStarted = carDictionary["lastStarted"] as? Date
            car.timesDriven = carDictionary["timesDriven"] as! Int16
            car.myChoice = carDictionary["myChoice"] as! Bool
            
            let imageName = carDictionary["imageName"] as? String
            let image = UIImage(named: imageName!)
            let imageData = image!.pngData()
            car.imageData = imageData
            
            if let colorDictionary = carDictionary["tintColor"] as? [String : Float] {
                car.tintColor = getColor(colorDictionary: colorDictionary)
            }
        }
    }
    
    private func getColor(colorDictionary: [String:Float]) -> UIColor {
        guard let red = colorDictionary["red"],
              let green = colorDictionary["green"],
              let blue = colorDictionary["blue"]
                
        else {return UIColor() }
        
        return UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1.0)
    }
    
    // MARK: - Actions
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
    }
    
    @IBAction func startEngineAction(_ sender: UIButton) {
    }
    
    @IBAction func rateAction(_ sender: UIButton) {
    }
}

