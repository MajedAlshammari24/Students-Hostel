//
//  RoomsApi.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 06/05/1443 AH.
//

import Foundation
import FirebaseFirestore

class Rooms {
    var images: [String]?
    var name: String?
    var description: String?
    var price: String?
}

extension Rooms {
    static func getRoomImage(dict: [String:Any]) -> Rooms {
        
        let rooms = Rooms()
        rooms.images = dict["images"] as? [String]
        rooms.name = dict["name"] as? String
        rooms.description = dict["description"] as? String
        rooms.price = dict["price"] as? String
        return rooms
    }
}

class RoomsApi {
    
    static func getRooms(completion: @escaping (Rooms) -> Void) {
        
        
        let refRooms = Firestore.firestore().collection("Rooms")
        refRooms.getDocuments { documents, error in
            
            guard let documents = documents?.documents else {return}
            for document in documents {
                refRooms.document(document.documentID).getDocument { document, error in
                    if let doc = document, doc.exists {
                        let room = Rooms.getRoomImage(dict: doc.data()!)
                        completion(room)
                    }
                }
            }
        }
    }
}
