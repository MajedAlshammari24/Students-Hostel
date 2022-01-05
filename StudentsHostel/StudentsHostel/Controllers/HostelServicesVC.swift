//
//  HostelServicesVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import UIKit
import Kingfisher

class HostelServicesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var requestArray = [Services]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        ServicesApi.getServices { services in
            DispatchQueue.main.async {
                self.requestArray.append(services)
                self.tableView.reloadData()
                self.removeSpinner()
            }
        }
        tableView.delegate = self
        tableView.dataSource = self

    }

   

}

extension HostelServicesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ServicesCell else { return UITableViewCell()}
        cell.serviceLabel.text = requestArray[indexPath.row].name
        cell.serviceDescription.text = requestArray[indexPath.row].description
        guard let images = requestArray[indexPath.row].image else { return UITableViewCell()}
        let url = URL(string: images)
        cell.serviceImage.kf.setImage(with: url,options: [.cacheOriginalImage])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}
