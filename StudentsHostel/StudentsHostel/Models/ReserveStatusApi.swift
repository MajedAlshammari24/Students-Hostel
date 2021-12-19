//
//  ReserveStatusApi.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 15/05/1443 AH.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class Reservation {
    var roomName: String?
    var price: String?
    var status: String?
}

extension Reservation {
    
    static func addReservation(uid: String, roomName: String, price: String, status: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let refReservation = db.collection("Reservations")
        refReservation.document(uid).setData(Reservation.createReserve(roomName: roomName, price: price, status: status))
        completion(true)
    }
    
    static func getReservation(dict: [String : Any]) -> Reservation {
        let reservation = Reservation()
        reservation.roomName = dict["roomName"] as? String
        reservation.price = dict["price"] as? String
        reservation.status = dict["status"] as? String
        return reservation
    }
    
    
    static func createReserve(roomName: String, price:String, status: String) -> [String : Any] {
        let newReserve = ["roomName":roomName,"price":price,"status":status] as [String : Any]
        return newReserve
    }
    
    
    static func getStatus(uid:String,completion: @escaping (Reservation) -> Void) {
        
        let refStatus = Firestore.firestore().collection("Reservations")
        
        refStatus.document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let status = Reservation.getReservation(dict: document.data()!)
                completion(status)
            }
        }
    }
    
    
}
