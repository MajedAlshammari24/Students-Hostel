

import Foundation
import FirebaseFirestore

class Services {
    var image: String?
    var name: String?
    var description:String?
}

extension Services {
    
    static func getServices(dic: [String : Any]) -> Services {
        let services = Services()
        services.image = dic["image"] as? String
        services.name = dic["name"] as? String
        services.description = dic["description"] as? String
        return services
    }
}

class ServicesApi {
    
    static func getServices(completion: @escaping (Services) -> Void) {
        let refServices = db.collection("Services")
        refServices.getDocuments { documents, error in
            guard let documents = documents?.documents else { return }
            for document in documents {
                refServices.document(document.documentID).getDocument { document, error in
                    if let doc = document, doc.exists {
                        let service = Services.getServices(dic: doc.data()!)
                        completion(service)
                    }
                }
            }
        }
    }
    
    
}
