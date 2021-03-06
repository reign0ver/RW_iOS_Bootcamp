//
//  ViewController.swift
//  ComparisonShopper
//
//  Created by Jay Strawn on 6/15/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Left
    @IBOutlet weak var titleLabelLeft: UILabel!
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var priceLabelLeft: UILabel!
    @IBOutlet weak var roomLabelLeft: UILabel!

    // Right
    @IBOutlet weak var titleLabelRight: UILabel!
    @IBOutlet weak var imageViewRight: UIImageView!
    @IBOutlet weak var priceLabelRight: UILabel!
    @IBOutlet weak var roomLabelRight: UILabel!

    var house1: House?
    var house2: House?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        house1 = House(address: "Av 123 Sidney Dori South 43-12", price: "$12,000", bedrooms: "3 bedrooms")
        
        setUpLeftSideUI()
        setUpRightSideUI()
    }

    func setUpLeftSideUI() {
        guard let house = house1 else { return }
        titleLabelLeft.text = house.address ?? ""
        priceLabelLeft.text = house.price ?? ""
        roomLabelLeft.text = house.bedrooms ?? ""
    }
    
    func setUpRightSideUI() {
        guard let house = house2 else {
            setupAlphaValuesRightView(0)
            return
        }
        
        setupAlphaValuesRightView(1)
        
        titleLabelRight.text = house.address ?? ""
        priceLabelRight.text = house.price ?? ""
        roomLabelRight.text = house.bedrooms ?? ""
    }
    
    private func setupAlphaValuesRightView (_ value: CGFloat) {
        titleLabelRight.alpha = value
        imageViewRight.alpha = value
        priceLabelRight.alpha = value
        roomLabelRight.alpha = value
    }

    @IBAction func didPressAddRightHouseButton(_ sender: Any) {
        openAlertView()
    }

    func openAlertView() {
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "address"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "price"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "bedrooms"
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
            var house = House()
            house.address = alert.textFields?[0].text
            house.price = alert.textFields?[1].text
            house.bedrooms = alert.textFields?[2].text
            self.house2 = house
            self.setUpRightSideUI()
        }))

        self.present(alert, animated: true, completion: nil)
    }

}

struct House {
    var address: String?
    var price: String?
    var bedrooms: String?
}

