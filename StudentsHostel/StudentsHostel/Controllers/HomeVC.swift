
import UIKit
import Kingfisher
import FirebaseFirestore
class HomeVC: UIViewController {
    
    var timer: Timer?
    var currentCellIndex = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    let userDefault = UserDefaults.standard
    var selectedRoomsType: Rooms?
    var reserveData = [Rooms]()
    var homePhotos: HomeImages?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        RoomsApi.getRooms { rooms in
            DispatchQueue.main.async {
                self.reserveData.append(rooms)
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

   
    func setDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: CollectionView Timer
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

// MARK: Browse Rooms in TableView
extension HomeVC: UITableViewDelegate,UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationController = segue.destination as! RoomsSelection
        destinationController.passedRoomsData = selectedRoomsType
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reserveData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RoomsCells else { return UITableViewCell()}
        cell.cellView.setCornerStyle()
        let reservesIndex = reserveData[indexPath.row]
        cell.roomName.text = reservesIndex.name?.localized
        cell.roomPrice.text = reservesIndex.price?.localized
        let url = URL(string: reservesIndex.roomShow ?? "")
        cell.roomImage.kf.setImage(with: url,options: [.cacheOriginalImage])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoomsType = reserveData[indexPath.row]
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
