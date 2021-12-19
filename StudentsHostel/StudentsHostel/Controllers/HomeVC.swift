//
//  HomeVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//
import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedRoomsType: Rooms?
    var requestArray = [Rooms]()
    var arrayOfImages = [HomeImages]()
    var arrayImagesSet: HomeImages?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoomsApi.getRooms { rooms in
            DispatchQueue.main.async {
                self.requestArray.append(rooms)
                self.tableView.reloadData()
            }
        }
        HomeImagesApi.getHomeImage { images in
            DispatchQueue.main.async {
                self.arrayOfImages.append(images)
                self.collectionView.reloadData()
            }
        }
        setDelegate()
        view.backgroundColor = .systemBackground
    }
    
    func setDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
}

extension HomeVC: UITableViewDelegate,UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationController = segue.destination as! RoomsSelection
        destinationController.arrayImages = selectedRoomsType
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RoomsCells else { return UITableViewCell()}
        cell.roomTypeLabel.text = requestArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoomsType =  requestArray[indexPath.row]
        performSegue(withIdentifier: "roomSelect", sender: nil)
    }
    
    
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayImagesSet?.homeImages?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HomePageImagesCell else { return UICollectionViewCell()}

        guard let arrImages = arrayImagesSet?.homeImages?[indexPath.row] else { return UICollectionViewCell()}

        guard let url = URL(string: arrImages) else { return UICollectionViewCell()}

        if let data = try? Data(contentsOf: url) {
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)

            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
