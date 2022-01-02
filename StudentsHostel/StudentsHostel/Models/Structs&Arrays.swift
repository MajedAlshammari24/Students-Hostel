//
//  Structs.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 04/05/1443 AH.
//

import Foundation
import UIKit


let cities = ["","Abha","Buraydah","AlBahah","Buq a","Dammam","Dhahran","Dumat Al-Jandal","Dawadmi","Hotat Bani Tamim","Hofuf","Hafr Al-Batin","Jeddah","Khafji","Khamis Mushait","Khobar","Al Majma'ah","Medina","Mecca","Qatif","Qurayyat","Rabegh","Rafha","Taif","Tabuk","Yanbu"]


let presentRoomsImages = [UIImage(named: "ShowStandardSingle"),UIImage(named: "ShowDeluxeSingle"),UIImage(named: "ShowStandardTwin"),UIImage(named: "ShowDeluxeTwin")]
//func downloadImages() {
//    ServicesApi.getServices { service in
//        self.urlString?.append(service.image ?? "")
//        guard let urlString = self.urlString else {return}
//
//        for urlImage in urlString {
//            guard let url = URL(string: urlImage) else {return}
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    self.serImage?.append(UIImage(data: data)!)
//                    self.serName?.append(service.name ?? "")
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
//}
