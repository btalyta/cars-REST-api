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
    var brands: [Brand] = []
    lazy var pickerView : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.car != nil){
            self.tfName.text = self.car.name
            self.tfPrice.text = "\(self.car.price)"
            self.tfBrand.text = self.car.brand
            self.scGasType.selectedSegmentIndex = self.car.gasType
            self.btAddEdit.setTitle("Update", for: .normal)
        }
        self.configToolbar()
        self.tfBrand.inputView = self.pickerView
        
        self.loadBrands()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadBrands(){
        REST.loadBrand { (brands) in
            if let brands =  brands{
                self.brands = brands.sorted(by: {$0.fipe_name < $1.fipe_name})
                DispatchQueue.main.async {
                    self.pickerView.reloadAllComponents()
                }
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        self.btAddEdit.isEnabled = false
        self.btAddEdit.backgroundColor = .gray
        self.btAddEdit.alpha = 0.75
        self.loading.startAnimating()
        
        if self.car == nil{
            self.car = Car()
        }
        self.car.name = self.tfName.text ?? " "
        self.car.brand = self.tfBrand.text ?? " "
        self.car.price = Double(self.tfPrice.text ?? "0")!
        self.car.gasType = self.scGasType.selectedSegmentIndex
        
        if (self.car._id == nil){
            REST.save(car: self.car) { (sucess) in
                self.goBack()
            }
        }else{
            REST.update(car: self.car, onComplete: { (sucess) in
                self.goBack()
            })
        }
    }
    
    func goBack(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func configToolbar(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        toolbar.tintColor = UIColor(red: 0.200, green: 0.565, blue: 0.576, alpha: 1.0)
        let btnCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.items = [btnCancel, space, btnDone]
        self.tfBrand.inputAccessoryView = toolbar

    }
    
    @objc func cancel(){
        self.tfBrand.resignFirstResponder()
    }
    
    @objc func done(){
        self.tfBrand.text = self.brands[self.pickerView.selectedRow(inComponent: 0)].fipe_name
        self.cancel()
    }

}

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.brands.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let brand = self.brands[row]
        return brand.fipe_name
    }
    
}
