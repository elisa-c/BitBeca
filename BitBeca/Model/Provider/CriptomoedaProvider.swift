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
//        let urlString = "https://rest.coinapi.io/v1/assets/"

        guard let url = URL(string: urlString) else {return}

        let task = URLSession.shared.dataTask(with: url) { ( responseBody, response, error) in
            guard let data = response else {return}

            let response = response as! HTTPURLResponse
            let responseBody = responseBody!
            print(response.statusCode)
            if !(400...550).contains(response.statusCode) {
                switch response.statusCode {
                case 400:
                    print("400 BadRequest -- Thereis something wrong with your request")
                        break
                case 401:
                    print("401 Unauthorized -- Your API key is wrong")
                    break
                case 403:
                    print("403 Forbidden --Your API key doesnt't have enough privileges to access this resource")
                    break
                case 429:
                    print("429 Too many requests -- You have exceeded your API key rate limits")
                    break
                case 550:
                    print("550 No data -- You requested specific single item that we don't have at this")
                    break
                default:
                    print("")
                    break
                }
            }

            do {
                let criptomoedas = try JSONDecoder().decode(APICriptomoedas.self, from: responseBody)
                let criptomoeda = criptomoedas.filter {$0.typeIsCrypto == 1 && $0.priceUsd ?? 0>0 && (($0.idIcon?.isEmpty) != nil)}
                completion(criptomoeda)
            } catch {
                print("Erro na decodificação: \(error)")

            }

        }

        task.resume()
    }

}
