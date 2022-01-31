
import UIKit

class TermsAndConditionsViewController: UIViewController {

    @IBOutlet weak var term1: UILabel!
    @IBOutlet weak var term2: UILabel!
    @IBOutlet weak var term3: UILabel!
    @IBOutlet weak var term4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        term1.text = "The student is a regular at the university and registered for the semester in which he wishes to reside in hostel".localized
        term2.text = "Has not been previously dismissed from the hostel as a result of violating the rules or regulations in force inside the residence".localized
        term3.text = "Adherence to university hostel regulations and rules and not violating them".localized
        term4.text = "By reserve a room you agree to that your reservation will start at the start of semester, and will expired at the end of same semester".localized
    }
    
}

