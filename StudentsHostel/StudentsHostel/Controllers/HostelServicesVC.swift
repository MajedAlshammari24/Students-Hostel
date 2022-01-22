

import UIKit
import Kingfisher

class HostelServicesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var servicesData = [Services]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        ServicesApi.getServices { services in
            DispatchQueue.main.async {
                self.servicesData.append(services)
                self.tableView.reloadData()
                self.removeSpinner()
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
    }


    
}

// MARK: Services TableView
extension HostelServicesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ServicesCell else { return UITableViewCell()}
        cell.serviceLabel.text = servicesData[indexPath.row].name
        cell.serviceDescription.text = servicesData[indexPath.row].description
        cell.cellView.setCornerStyle()
        guard let images = servicesData[indexPath.row].image else { return UITableViewCell()}
        
        let url = URL(string: images)
        cell.serviceImage.kf.setImage(with: url,options: [.cacheOriginalImage])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    
    
}
