//
//  ServiceLauncher.swift
//  CollectionView
//
//  Created by Tugce Aybak on 8.05.2021.
//

import Foundation

class ServiceLauncher : NSObject {
    let serviceAddress = URL(string: "https://jsonblob.com/api/jsonBlob/a07152f5-775c-11eb-a533-c90b9d55001f".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    
    func callService(completionHandler: @escaping (DataModel) -> Void, errorHandler: @escaping (Error) -> Void) {

        let task = URLSession.shared.dataTask(with: serviceAddress!, completionHandler: { (data, response, error) in
          if let error = error {
            errorHandler(error)
            return
          }
          
          
          if let data = data,
            let dataModel = try? JSONDecoder().decode(DataModel.self, from: data) {
            completionHandler(dataModel)
          }
        })
        task.resume()
      }
}
