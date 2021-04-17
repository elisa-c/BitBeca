//
//  CriptomoedaProvider.swift
//  BitBeca
//
//  Created by Matheus Golke Cardoso on 15/04/21.
//
import Foundation

class CriptomoedaProvider {

    func getData(completion:@escaping([APICriptomoeda]) -> Void) {

        let urlString = "https://rest.coinapi.io/v1/assets/?apikey=1F8A5E86-F1C9-41C7-B8BB-9DB1B81FDE7C"
        guard let url = URL(string: urlString) else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {return}
            do {
                let criptomoedas = try JSONDecoder().decode(APICriptomoedas.self, from: data)
                completion(criptomoedas)
            } catch {
                print(error)
           }

        }

        task.resume()
    }

}
