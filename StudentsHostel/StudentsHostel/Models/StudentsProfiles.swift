//
//  StudentsProfiles.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 05/05/1443 AH.
//

import Foundation
import UIKit

class Student {
    var name: String?
    var email: String?
    var mobileNumber: String?
    var studentID: Int?
    var city: String?
    var imageProfile: String?
}

extension Student {
    
    static func getUser(dict: [String: Any]) -> Student {
        let student = Student()
        
        student.name = dict["name"] as? String
        student.email = dict["email"] as? String
        student.mobileNumber = dict["mobileNumber"] as? String
        student.city = dict["city"] as? String
        student.studentID = dict["studentID"] as? Int
        student.imageProfile = dict["imageProfile"] as? String
        return student
    }
    
    static func createUser(name:String,email:String,mobileNumber:String,studentID:Int,city:String,imageProfile:String) -> [String: Any] {
        
        let newStudent = ["name":name,
                          "email":email,
                          "mobileNumber":mobileNumber,
                          "studentID":studentID,
                          "city":city,
                          "imageProfile":imageProfile
                         ] as [String : Any]
        return newStudent
        
    }
    
    static func updateInfo(name:String,email:String,mobileNumber:String) -> [String: Any] {
        
        let newStudent = ["name":name,
                          "email":email,
                          "mobileNumber":mobileNumber,
                         ] as [String : Any]
        return newStudent
        
    }
    static func putImageProfile(imageProfileUrl:String) -> [String: Any] {
        
        let newStudent = ["imageProfile":imageProfileUrl
                         ] as [String : Any]
        return newStudent
        
    }
}
