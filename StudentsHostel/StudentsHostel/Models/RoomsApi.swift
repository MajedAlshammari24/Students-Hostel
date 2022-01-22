

import Foundation
import FirebaseFirestore


class Rooms {
    var images: [String]?
    var name: String?
    var roomName: String?
    var roomType: String?
    var bedType: String?
    var bathroomType: String?
    var price: String?
    var roomShow: String?
}

extension Rooms {
    static func getRoomImage(dict: [String:Any]) -> Rooms {
        
        let rooms = Rooms()
        rooms.images = dict["images"] as? [String]
        rooms.name = dict["name"] as? String
        rooms.roomName = dict["roomName"] as? String
        rooms.roomType = dict["roomType"] as? String
        rooms.bedType = dict["bedType"] as? String
        rooms.bathroomType = dict["bathroomType"] as? String
        rooms.price = dict["price"] as? String
        rooms.roomShow = dict["roomShow"] as? String
        return rooms
    }
}

class RoomsApi {
    
    static func getRooms(completion: @escaping (Rooms) -> Void) {
        
        let refRooms = db.collection("Rooms")
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
