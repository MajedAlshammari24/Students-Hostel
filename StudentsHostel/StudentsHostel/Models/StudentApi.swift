//
//  StudentApi.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 05/05/1443 AH.
//

import Foundation
import FirebaseFirestore
import UIKit

class StudentApi {
    
    static func addStudent(uid:String,name:String,email:String,mobileNumber:String,studentID:Int32,city:String,completion: @escaping (Bool) -> Void) {
        let refStudents = Firestore.firestore().collection("Students")
        refStudents.document(uid).setData(Student.createUser(name: name, email: email, mobileNumber: mobileNumber, studentID: Int(studentID), city: city))
        
        completion(true)
        
    }
    
    static func getStudent(uid:String,completion: @escaping (Student) -> Void) {
        
        let refStudents = Firestore.firestore().collection("Students")
        
        refStudents.document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let student = Student.getUser(dict: document.data()!)
                completion(student)
            }
        }
        
    }
    
}

