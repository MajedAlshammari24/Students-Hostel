//
//  RoomsSelection.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 04/05/1443 AH.
//
import FirebaseAuth
import FirebaseFirestore
import UIKit
public var check : Bool?
class RoomsSelection: UIViewController {
    
    @IBOutlet weak var checkBoxButton: UIButton!
    
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomType: UILabel!
    @IBOutlet weak var bedType: UILabel!
    @IBOutlet weak var bathroomType: UILabel!
    @IBOutlet weak var roomPrice: UILabel!
    var arrayImages: Rooms?
    var setArrayImages: Rooms?
    var timer: Timer?
    var currentCellIndex = 0
    var downloadedImages : [UIImage] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setArrayImages = arrayImages
        roomsImagesDownload()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        startTimer()
        roomName.text = arrayImages?.roomName
        roomType.text = arrayImages?.roomType
        bedType.text = arrayImages?.bedType
        bathroomType.text = arrayImages?.bathroomType
        roomPrice.text = arrayImages?.price
        checkBoxButton.setImage(UIImage(systemName: "app"), for: .normal)
        
    }
    
    
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            if sender.image(for: .normal) == UIImage(systemName: "app") {
                sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            } else {
                sender.setImage(UIImage(systemName: "app"), for: .normal)
            }
        }
    }
    
    
    
    
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        if currentCellIndex < (setArrayImages?.images?.count ?? 0) - 1 {
            currentCellIndex += 1
        }
        else {
            currentCellIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    
    
    
    @IBAction func reserveCompletion(_ sender: UIButton) {
        if checkBoxButton.imageView?.image != UIImage(systemName: "checkmark.square") {
            termsAlert()
            check = false
        } else {
            
                let roomStatus = "Pending"
            Reservation.addReservation(uid: Auth.auth().currentUser?.uid ?? "", roomName: setArrayImages?.name ?? "", price: setArrayImages?.price ?? "", status: roomStatus)
            
            
            performSegue(withIdentifier: Identifier.completion.rawValue, sender: nil)
            check = true
        }
    }
    
    
    func termsAlert(){
        let alert = UIAlertController(title: "You did not agree", message: "Please Agree to our terms and conditions", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Terms And Conditions", style: .default, handler: { terms in
            self.performSegue(withIdentifier: Identifier.terms.rawValue, sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}


extension RoomsSelection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func roomsImagesDownload() {
        guard let arrayImages = setArrayImages?.images else { return }
        for arrayImage in arrayImages {
            guard let url = URL(string: arrayImage) else { return }
            if let data = try? Data(contentsOf: url) {
                self.downloadedImages.append(UIImage(data: data) ?? UIImage())
                self.collectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? RoomsImages else { return UICollectionViewCell()}
        
        cell.roomsImageView.image = downloadedImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
    
}
