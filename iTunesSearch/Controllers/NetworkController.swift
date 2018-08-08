//
//  NetworkController.swift
//  iTunesSearch
//
//  Created by Cameron Moss on 8/6/18.
//  Copyright © 2018 Cameron Moss. All rights reserved.
//

import UIKit

class NetworkController: NSObject {
    
    static func dataAtURL(url: URL, completion: @escaping (_ data: Data?) -> Void) {
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, _, error) -> Void in
            if error != nil {
                //error exists
                print("Error in \(#function) - \(error!.localizedDescription)")
                completion(nil)
            } else {
                completion(data)
            }
        }
        dataTask.resume()
    }
}
