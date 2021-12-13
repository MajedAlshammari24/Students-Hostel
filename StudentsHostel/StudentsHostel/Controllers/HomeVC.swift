//
//  HomeVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//
import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedRoomsType: Rooms?
    var requestArray = [Rooms]()
    override func viewDidLoad() {
        super.viewDidLoad()
        RoomsApi.getRooms { rooms in
            DispatchQueue.main.async {
                self.requestArray.append(rooms)
                self.tableView.reloadData()
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    

  

}

extension HomeVC: UITableViewDelegate,UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "roomSelect" {
            if let indexPaths = tableView.indexPathsForSelectedRows{
                let destinationController = segue.destination as! RoomsSelection
//                destinationController.imagesPass = rooms.photos
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RoomsCells else { return UITableViewCell()}
        cell.roomTypeLabel.text = requestArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedRoomsType =  requestArray[indexPath.row]
        performSegue(withIdentifier: "roomSelect", sender: nil)
    }
    
    
    
}
