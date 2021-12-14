//
//  Arrays.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 03/05/1443 AH.
//

import Foundation
import UIKit

//let roomsType = ["Standard Single Room","Deluxe Single Room","Standard Twin Sharing Room","Deluxe Twin Sharing Room"]

let images = [UIImage(named: "Mosque"),UIImage(named: "Theater"),UIImage(named: "Medical"),UIImage(named: "atm"),UIImage(named: "Parking"),UIImage(named: "Stadium"),UIImage(named: "Transport"),UIImage(named: "Router")]

//let servicesList = ["Mosque","Hostel Theater","Medical Clinic","ATM","Shaded Parking","Sports Stadiums","Students Transporation","Wired Internet Supported"]


//let singleStandard = [UIImage(named: "StandardSingle1"),UIImage(named: "StandardSingle2"),UIImage(named: "StandardSingle3")]
//
//let singleDeluxe = [UIImage(named: "DeluxeSingle2"),UIImage(named: "DeluxeSingle2"),UIImage(named: "DeluxeSingle2")]
//
//let sharingStandard = [UIImage(named: "StandardTwin1"),UIImage(named: "StandardTwin2"),UIImage(named: "StandardTwin3")]
//
//let sharingDeluxe = [UIImage(named: "DeluxeTwin1"),UIImage(named: "DeluxeTwin2"),UIImage(named: "DeluxeTwin3")]

func downloadImage(urls: [String], completion: @escaping (_ images:[UIImage?]) -> Void) {
    let group = DispatchGroup()
    var images: [UIImage?] = .init(repeating: nil, count: urls.count)
    for(index, urlString) in urls.enumerated() {
        group.enter()
        DispatchQueue.global().async {
            var image: UIImage?
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url){
                    image = UIImage(data: data)
                }
            }
            images[index] = image
            group.leave()
        }
    }
    group.notify(queue: .main) {
        completion(images)
    }
}
