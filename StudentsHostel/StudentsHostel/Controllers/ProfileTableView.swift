//
//  ProfileTableView.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 02/06/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class ProfileTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var profileInfo : [Student] = []
    var profileStudent : Student?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        StudentApi.getStudent(uid: Auth.auth().currentUser?.uid ?? "") { student in
            self.profileInfo.append(student)
            self.profileStudent = student
            self.tableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mobile")
            cell?.textLabel?.text = "XX"
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mobile")
            cell?.textLabel?.text = "X1"
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mobile")
            cell?.textLabel?.text = "X2"
            return cell ?? UITableViewCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mobile")
            cell?.textLabel?.text = "X3"
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
   
}
