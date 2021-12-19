//
//  HomeImagesApi.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 15/05/1443 AH.
//

import Foundation
import FirebaseFirestore

class HomeImages {
    var homeImages: [String]?
}

extension HomeImages {
    static func getHomeImages(dict: [String:Any]) -> HomeImages {
        
        let images = HomeImages()
        images.homeImages = dict["homeImages"] as? [String]
        return images
    }
}

class HomeImagesApi {
    
    static func getHomeImage(completion: @escaping (HomeImages) -> Void) {
        
        
        let refImages = Firestore.firestore().collection("HomePageImages")
        refImages.getDocuments { documents, error in
            
            guard let documents = documents?.documents else {return}
            for document in documents {
                refImages.document(document.documentID).getDocument { document, error in
                    if let doc = document, doc.exists {
                        let image = HomeImages.getHomeImages(dict: doc.data()!)
                        completion(image)
                    }
                }
            }
        }
    }
}

