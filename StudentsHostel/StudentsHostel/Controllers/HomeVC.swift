//
//  HomeVC.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//
import UIKit
import FirebaseFirestore
class HomeVC: UIViewController {
    
    var timer: Timer?
    var currentCellIndex = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedRoomsType: Rooms?
    var requestArray = [Rooms]()
    // var arrayOfImages : HomeImages?
    
    var imagesDownloaded:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        RoomsApi.getRooms { rooms in
            DispatchQueue.main.async {
                self.requestArray.append(rooms)
                self.tableView.reloadData()
            }
        }
        homeImagesDownload()
        
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startTimer()
    }
    
    func homeImagesDownload() {
        HomeImagesApi.getHomeImage { photos in
            DispatchQueue.main.async {
                let arrImages = photos.homeImages
                guard let arrImages = arrImages else {return}
                for arry in arrImages {
                    guard let url = URL(string: arry) else {return}
                    do {
                        let data = try Data(contentsOf: url)
                        self.imagesDownloaded.append(UIImage(data: data)!)
                        self.collectionView.reloadData()
                        self.removeSpinner()
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
                
                self.setDelegate()
            }
        }
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
        if currentCellIndex < (imagesDownloaded.count) - 1 {
            currentCellIndex += 1
        }
        else {
            currentCellIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    //    override func viewDidAppear(_ animated: Bool) {
    //        DispatchQueue.main.async {
    //
    //        }
    //    }
    
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
        //        count = arrayOfImages?.homeImages?.count
        return imagesDownloaded.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HomePageImagesCell else { return UICollectionViewCell()}
        
        cell.imageView.image = imagesDownloaded[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
