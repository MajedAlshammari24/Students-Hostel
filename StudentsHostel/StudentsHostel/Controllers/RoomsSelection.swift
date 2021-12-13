//
//  RoomsSelection.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 04/05/1443 AH.
//

import UIKit

class RoomsSelection: UIViewController {

//    var imagesSelected:Rooms = Rooms(name: "", description: "", price: "", photos: [])
    
    var imagesPass : [UIImage?] = []
    
    var requestArray = [Rooms]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        downloadImage()
    }

    func downloadImage() {
        RoomsApi.getRooms { room in
            let urlString = room.images
            guard let url = URL(string: urlString!) else { return }
            let getData = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    print("-----------------\(image)")
            }

        }
            getData.resume()
    }
}
    
    

}

extension RoomsSelection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requestArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? RoomsImages else { return UICollectionViewCell()}
        
//        cell.roomsImageView.image = requestArray[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
    
}
