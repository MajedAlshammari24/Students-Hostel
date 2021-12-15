//
//  HostelServicesVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import UIKit

class HostelServicesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var requestArray = [Services]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ServicesApi.getServices { services in
            DispatchQueue.main.async {
                self.requestArray.append(services)
                self.tableView.reloadData()
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
        
        guard let images = requestArray[indexPath.row].image else { return UITableViewCell()}
        guard let url = URL(string: images) else { return UITableViewCell()}
        
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url) {
                cell.serviceImage.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}
