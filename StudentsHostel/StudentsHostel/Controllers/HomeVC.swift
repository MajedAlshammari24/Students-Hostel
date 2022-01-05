//
//  HomeVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//
import UIKit
import Kingfisher
import FirebaseFirestore
class HomeVC: UIViewController {
    
    var timer: Timer?
    var currentCellIndex = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedRoomsType: Rooms?
    var requestArray = [Rooms]()
    var homePhotos: HomeImages?
    var imagesDownloaded:[UIImage] = []
    var roomsShowImage:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        RoomsApi.getRooms { rooms in
            DispatchQueue.main.async {
                self.requestArray.append(rooms)
                self.tableView.reloadData()
                self.removeSpinner()
            }
        }
        HomeImagesApi.getHomeImage { photos in
            self.homePhotos = photos
            self.collectionView.reloadData()
            self.startTimer()
        }
        setDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    

    func setDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        guard let count = homePhotos?.homeImages?.count else {return}
        currentCellIndex += 1
        if currentCellIndex > count - 1 {
            currentCellIndex = 0
        }
        
        if !(homePhotos?.homeImages?.isEmpty ?? true) {
            collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
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
        cell.cellView.layer.shadowColor = UIColor.gray.cgColor
        cell.cellView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.cellView.layer.shadowOpacity = 2.0
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.cornerRadius = 12.0
        cell.roomName.text = requestArray[indexPath.row].name
        cell.roomPrice.text = requestArray[indexPath.row].price
        let url = URL(string: requestArray[indexPath.row].roomShow ?? "")
        cell.roomImage.kf.setImage(with: url,options: [.cacheOriginalImage])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoomsType =  requestArray[indexPath.row]
        performSegue(withIdentifier: "roomSelect", sender: nil)
    }
    
    
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePhotos?.homeImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HomePageImagesCell else { return UICollectionViewCell()}
        guard let arrayPhotos = homePhotos?.homeImages?[indexPath.row] else { return UICollectionViewCell()}
        cell.imageView.kf.setImage(with: URL(string: arrayPhotos),options: [.cacheOriginalImage])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
