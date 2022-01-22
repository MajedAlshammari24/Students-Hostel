
import FirebaseAuth
import FirebaseFirestore
import UIKit
import Kingfisher

var reserveCheck:Bool?
class RoomsSelection: UIViewController {
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomType: UILabel!
    @IBOutlet weak var bedType: UILabel!
    @IBOutlet weak var bathroomType: UILabel!
    @IBOutlet weak var roomPrice: UILabel!
    @IBOutlet weak var roomSelectionView: UIImageView!
    var passedRoomsData: Rooms?
    var setArrayImages: Rooms?
    var timer: Timer?
    var currentCellIndex = 0
    var downloadedImages : [UIImage] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomSelectionView.layer.cornerRadius = 20
        setArrayImages = passedRoomsData
        setDelegate()
        collectionView.reloadData()
        startTimer()
        configureLabels()
        checkBoxButton.setImage(UIImage(systemName: "app"), for: .normal)
    }
    
    // MARK: Show Rooms Info
    func configureLabels() {
        roomName.text = passedRoomsData?.roomName
        roomType.text = passedRoomsData?.roomType
        bedType.text = passedRoomsData?.bedType
        bathroomType.text = passedRoomsData?.bathroomType
        roomPrice.text = passedRoomsData?.price
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: CheckBox Button
    @IBAction func checkBoxAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            if sender.image(for: .normal) == UIImage(systemName: "app") {
                sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            } else {
                sender.setImage(UIImage(systemName: "app"), for: .normal)
            }
        }
    }
    
    
    
    
    // MARK: CollectionView Timer
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        guard let count = setArrayImages?.images?.count else {return}
        currentCellIndex += 1
        if currentCellIndex > count - 1 {
            currentCellIndex = 0
        }
        
        if !(setArrayImages?.images?.isEmpty ?? true) {
            collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    // MARK: Go To Read Terms and Conditions
    @IBAction func readTerms(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Terms") as! TermsAndConditionsViewController
        present(vc, animated: true)
        
        
    }
    
    
    // MARK: If Reserve Button Pressed
    @IBAction func reserveCompletion(_ sender: UIButton) {
        if checkBoxButton.imageView?.image != UIImage(systemName: "checkmark.square") {
            termsAlert()
            reserveCheck = false
        } else {
                let roomStatus = "Pending"
            Reservation.addReservation(uid: Auth.auth().currentUser?.uid ?? "", roomName: setArrayImages?.name ?? "", price: setArrayImages?.price ?? "", status: roomStatus)
            reserveCheck = true
            performSegue(withIdentifier: Identifier.completion.rawValue, sender: nil)
            
        }
    }
    
    
}

// MARK: CollectionView Set of rooms pictures
extension RoomsSelection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setArrayImages?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? RoomsImages else { return UICollectionViewCell()}
        guard let imagesArraySet = setArrayImages?.images?[indexPath.row] else { return UICollectionViewCell()}
        cell.roomsImageView.kf.setImage(with: URL(string: imagesArraySet),options: [.cacheOriginalImage])
            
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
}
