//
//  TermsAndConditionsViewController.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 10/05/1443 AH.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    @IBOutlet weak var term1: UILabel!
    @IBOutlet weak var term2: UILabel!
    @IBOutlet weak var term3: UILabel!
    @IBOutlet weak var term4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        term1.text = "●The student is a regular at the university and registered for the semester in which he wishes to reside in hostel"
        term2.text = "●Has not been previously dismissed from the hostel as a result of violating the rules or regulations in force inside the residence"
        term3.text = "●Adherence to university hostel regulations and rules and not violating them"
        term4.text = "●If you are not coming to your room more than 1 week (without telling the manager), it may result your reservation to being cancelled"
    }
    

   

}
