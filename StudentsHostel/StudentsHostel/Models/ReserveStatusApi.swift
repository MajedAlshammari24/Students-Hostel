

import Foundation
import FirebaseAuth
import FirebaseFirestore


class Reservation {
    var roomName: String?
    var price: String?
    var status: String?
}

extension Reservation {
    
    static func addReservation(uid: String, roomName: String, price: String, status: String) {
        let refReservation = db.collection("Reservations")
        refReservation.document(uid).setData(Reservation.createReserve(roomName: roomName, price: price, status: status))
        
    }
    
    static func getReservation(dict: [String : Any]) -> Reservation {
        let reservation = Reservation()
        reservation.roomName = dict["roomName"] as? String
        reservation.price = dict["price"] as? String
        reservation.status = dict["status"] as? String
        return reservation
    }
    
    static func deleteReservation(uid:String) {
        db.collection("Reservations").document(uid).delete()
    }
    
    static func createReserve(roomName: String, price:String, status: String) -> [String : Any] {
        let newReserve = ["roomName":roomName,"price":price,"status":status] as [String : Any]
        return newReserve
    }
    
    
    static func getStatus(uid:String,completion: @escaping (Reservation?,Error?) -> Void) {
        
        let refStatus = db.collection("Reservations")
        
        refStatus.document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let status = Reservation.getReservation(dict: document.data()!)
                completion(status,nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    
}
