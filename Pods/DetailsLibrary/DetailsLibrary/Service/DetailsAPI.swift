//
//  DetailsAPI.swift
//  DetailsLibrary
//
//  Created by Elisa Camillo on 19/04/21.
//

import Foundation

class DetailsAPI {
    func getDetails(abrevDetails: String, completion:@escaping(DetailsCodable) -> Void) {
        let apikey = "1F8A5E86-F1C9-41C7-B8BB-9DB1B81FDE7C"

        let baseURL = "https://rest.coinapi.io/v1/assets/\(abrevDetails)?apikey=\(apikey)"

        guard let url = URL(string: baseURL) else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {return}
            do {
                let coins = try JSONDecoder().decode([DetailsCodable].self, from: data)
                guard let coin = coins.first else {return}
                completion(coin)
            } catch {
                print(error)
            }

        }

        task.resume()
    }
}
