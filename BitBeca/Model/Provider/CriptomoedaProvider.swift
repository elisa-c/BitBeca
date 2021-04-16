//
//  CriptomoedaProvider.swift
//  BitBeca
//
//  Created by Matheus Golke Cardoso on 15/04/21.
//

import Foundation

class CriptomoedaProvider {
    var listaCriptoViewModel: [CriptoViewModel]=[]

    func getData() {

        let urlString = "https://rest.coinapi.io/v1/assets/?apikey=1F8A5E86-F1C9-41C7-B8BB-9DB1B81FDE7C"
        guard let url = URL(string: urlString) else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, _ response, error) in
            guard let data = data, error == nil else {return}
            do {
                let criptomoedas = try JSONDecoder().decode([APICriptomoedas].self, from: data)
                // Implementar a chamada de todos os itens da API
                for int in 0...9 {
                    let criptomoeda = criptomoedas.filter {$0.typeIsCrypto == 1 && $0.priceUsd ?? 0>0}
                    guard let name = criptomoeda[int].name else {return}
                    guard let sigla = criptomoeda[int].assetID else {return}
                    guard let price = criptomoeda[int].priceUsd else {return}
                    let criptoAtual = CriptoViewModel(name: name, sigla: sigla, price: price)
                    self.listaCriptoViewModel.append(criptoAtual)
                    print("Nome \(self.listaCriptoViewModel[int].name)")
                    print("Sigla \(self.listaCriptoViewModel[int].sigla)")
                    print("price \(String(format: "%.2f", self.listaCriptoViewModel[int].price))")
                }
            } catch {
                print(error.localizedDescription)
           }
        }
        task.resume()
    }
}
