//
//  StudentApi.swift
//  StudentsHostel
//
//  Created by Majed Alshammari on 05/05/1443 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import UIKit

class StudentApi {
    
    static func addStudent(uid:String,name:String,email:String,mobileNumber:String,studentID:Int32,city:String,completion: @escaping (Bool) -> Void) {
        let refStudents = Firestore.firestore().collection("Students")
        refStudents.document(uid).setData(Student.createUser(name: name, email: email, mobileNumber: mobileNumber, studentID: Int(studentID), city: city, imageProfile: " "))
        
        completion(true)
        
    }
    
    static func addImageProfile(uid:String,url:String) {
        let refStudents = Firestore.firestore().collection("Students")
        refStudents.document(uid).setData(Student.putImageProfile(imageProfileUrl: url),merge: true)
        
        
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
    
    static func uploadStudentImage(studentImage:UIImage, completion: @escaping (Bool,String?) -> Void) {
        let storageRef = Storage.storage().reference()
        let profileImageRef = storageRef.child("Students").child(Auth.auth().currentUser?.uid ?? "").child("\(String(Int((arc4random())))).jpg")
        
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        guard let data = studentImage.pngData() else { return }
        
        profileImageRef.putData(data, metadata: uploadMetaData) { (uploadedImageMeta, error) in
            if error != nil {
                print("error took place\(String(describing: error?.localizedDescription))")
            } else {
                profileImageRef.downloadURL { url, error in
                    let urlDownload = url?.absoluteString
                    completion(true,urlDownload)
                }
                print("Meta data of uploaded image \(String(describing: uploadMetaData))")
            }
            
        }
    }
    
}

