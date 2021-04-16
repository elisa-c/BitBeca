//
//  IconProvider.swift
//  BitBeca
//
//  Created by Matheus Golke Cardoso on 15/04/21.
//

import Foundation

// class IconProvider{
//
//    func getIcon(){
//
//        let urlString = "https://rest.coinapi.io/v1/assets/icons/32?apikey=1F8A5E86-F1C9-41C7-B8BB-9DB1B81FDE7C"
//        guard let url = URL(string: urlString) else {return}
//        let task = URLSession.shared.dataTask(with: url) { (data, _ response, error) in
//            guard let data = data, error == nil else {return}
//            do {
//                let icon = try JSONDecoder().decode(.self, from: data)
//            } catch {
//                print(error.localizedDescription)
//           }
//        }
//        task.resume()
//
//    }
//
// }
