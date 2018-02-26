//
//  AddEditViewController.swift
//  Cars
//
//  Created by Bárbara Souza on 26/02/18.
//  Copyright © 2018 Bárbara Souza. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var car: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        if self.car == nil{
            self.car = Car()
        }
        self.car.name = self.tfName.text ?? " "
        self.car.brand = self.tfBrand.text ?? " "
        self.car.price = Double(self.tfPrice.text ?? "0")!
        self.car.gasType = self.scGasType.selectedSegmentIndex
        
        REST.save(car: self.car) { (sucess) in
            self.goBack()
        }
    }
    
    func goBack(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }

}
