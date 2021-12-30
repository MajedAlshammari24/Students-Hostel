//
//  ServicesDescription.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 15/05/1443 AH.
//

import UIKit

class ServicesDescription: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                as? ServicesDescriptionCell else { return UITableViewCell() }

        cell.cellView.layer.shadowColor = UIColor.gray.cgColor
        cell.cellView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.cellView.layer.shadowOpacity = 2.0
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.cornerRadius = 12.0
        return cell
    }

   

}
