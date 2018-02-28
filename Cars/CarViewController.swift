//
//  CarViewController.swift
//  Cars
//
//  Created by Bárbara Souza on 26/02/18.
//  Copyright © 2018 Bárbara Souza. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {

    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var lbGasType: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    var car: Car!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = self.car.name
        self.lbBrand.text = self.car.brand
        self.lbGasType.text = self.car.gas
        self.lbPrice.text = "R$ \(self.car.price)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newView = segue.destination as! AddEditViewController
        newView.car = self.car
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
