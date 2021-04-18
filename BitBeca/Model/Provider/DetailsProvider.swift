//
//  DetailsProvider.swift
//  BitBeca
//
//  Created by Elisa Camillo on 18/04/21.
//

import Foundation

class DetailsProvider {
    func getDetails(abrevDetails: String, completion:@escaping([APIDetail]) -> Void) {
        let apikey = "1F8A5E86-F1C9-41C7-B8BB-9DB1B81FDE7C"

        let baseURL = "https://rest.coinapi.io/v1/assets/\(abrevDetails)?apikey=\(apikey)"

        guard let url = URL(string: baseURL) else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {return}
            do {
                let coin = try JSONDecoder().decode(APIDetails.self, from: data)
                completion(coin)
            } catch {
                print(error)
            }

        }

        task.resume()
    }
}
