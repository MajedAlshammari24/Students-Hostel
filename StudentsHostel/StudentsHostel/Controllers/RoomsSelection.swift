//
//  RoomsSelection.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 04/05/1443 AH.
//

import UIKit

class RoomsSelection: UIViewController {
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var roomPrice: UILabel!
    var arrayImages: Rooms?
    var setArrayImages: Rooms?
    var timer: Timer?
    var currentCellIndex = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setArrayImages = arrayImages
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        startTimer()
        roomDescription.text = arrayImages?.description
        roomPrice.text = arrayImages?.price
        checkBoxButton.setImage(UIImage(systemName: "app"), for: .normal)
        //checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
    }
    
    
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            if sender.image(for: .normal) == UIImage(systemName: "app") {
                sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                //sender.isSelected = !sender.isSelected
                //sender.setImage(UIImage(systemName: "app"), for: .normal)
            } else {
                //sender.isSelected = !sender.isSelected
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
        } else {
            performSegue(withIdentifier: Identifier.completion.rawValue, sender: nil)
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setArrayImages?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? RoomsImages else { return UICollectionViewCell()}
        
        guard let arrayImages = setArrayImages?.images?[indexPath.row] else { return UICollectionViewCell() }
            guard let url = URL(string: arrayImages) else { return UICollectionViewCell() }
            if let data = try? Data(contentsOf: url) {
                cell.roomsImageView.image = UIImage(data: data)
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
