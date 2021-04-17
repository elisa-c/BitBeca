//
//  ViewController.swift
//  BitBeca
//
//  Created by Renilson Moreira Ferreira on 13/04/21.
//
import UIKit
import Commons
import Details
import DetailsLibrary

enum CoresBitBeca {
    case corAbacate
    case corBlack
    var corSelecionada: UIColor {
        switch self {
        case .corAbacate: return  #colorLiteral(red: 0.5386368036, green: 0.5939192176, blue: 0.337885499, alpha: 1)
        case .corBlack: return  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - IBOutlets

    @IBOutlet weak var tableBitcoins: UITableView!
    @IBAction func testeDetalhes(_ sender: Any) {
        let vc = DetailsLibrary.DetailsViewController.self
        let vcShow = vc.fromSB()
        navigationController?.pushViewController(vcShow, animated: true)
    }

    let myProvider = CriptomoedaProvider()
    var listaCriptoViewModel: [CriptoViewModel]=[]
    @IBOutlet weak var myLabelData: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        cores(cor: .corBlack)
        getCurrentDateTime()
        self.tableBitcoins.dataSource = self
        self.tableBitcoins.delegate = self
        self.tableBitcoins.backgroundColor = .black
        getDataCriptomoedas()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - Cores
    func cores(cor: CoresBitBeca) {
        self.view.backgroundColor = cor.corSelecionada
    }
    // MARK: - Funcção para gerar a data atual
    func getCurrentDateTime() {
        let data = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY"
        formatter.locale = Locale(identifier: "pt_BR")
        myLabelData.text = formatter.string(from: data)
        myLabelData.textColor = UIColor.white
    }

    func getDataCriptomoedas() {

        myProvider.getData { (results) in

            for i in 0...20 {
                let criptomoeda = results.filter {$0.typeIsCrypto == 1 && $0.priceUsd ?? 0>0 && (($0.idIcon?.isEmpty) != nil)}
                guard let name = criptomoeda[i].name else {return}
                guard let sigla = criptomoeda[i].assetID else {return}
                guard let price = criptomoeda[i].priceUsd else {return}
                guard let idIcon = criptomoeda[i].idIcon else {return}
                let criptoAtual = CriptoViewModel(name: name, sigla: sigla, price: price, idIcon: idIcon)
                self.listaCriptoViewModel.append(criptoAtual)
                //                        print("Nome \(self.listaCriptoViewModel[i].name)")
                //                        print("Sigla \(self.listaCriptoViewModel[i].sigla)")
                //                        print("price \(String(format: "%.3f", self.listaCriptoViewModel[i].price))")
                //                        print("IdIcont \(self.listaCriptoViewModel[i].idIcon)")
            }
            DispatchQueue.main.async {
                self.tableBitcoins.reloadData()
            }
        }

    }

    // MARK: - TableView Tela Principal
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listaCriptoViewModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBitcoin", for: indexPath) as! BitcoinsTableViewCell

        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.0392, green: 0.4078, blue: 0, alpha: 1)
        cell.selectedBackgroundView = backgroundView

        cell.labelNameBitcoin.text = listaCriptoViewModel[indexPath.row].name
        cell.labelSiglaBitcoin.text = listaCriptoViewModel[indexPath.row].sigla
        cell.labelPriceBitcoin.text = ("$ \(String(format: "%.2f", self.listaCriptoViewModel[indexPath.row].price))")
        let idIcon = listaCriptoViewModel[indexPath.row].idIcon
        let id = idIcon.replacingOccurrences(of: "-", with: "")
        cell.getIcon(idIcon: id)
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let siglaDetalhes = listaCriptoViewModel[indexPath.row].sigla
        testeAPIDetalhes(siglaDetalhes: siglaDetalhes, completion: {(result) in
            print(result[0].volume1HrsUsd!)

            DispatchQueue.main.async {
                let vc = DetailsLibrary.DetailsViewController.self
                let vcShow = vc.fromSB()
                self.navigationController?.pushViewController(vcShow, animated: true)

                        }

        })
    }

    func testeAPIDetalhes(siglaDetalhes: String, completion:@escaping([APICriptomoeda]) -> Void) {
        let apikey = "1F8A5E86-F1C9-41C7-B8BB-9DB1B81FDE7C"

        let baseURL = "https://rest.coinapi.io/v1/assets/\(siglaDetalhes)?apikey=\(apikey)"

        guard let url = URL(string: baseURL) else {return}

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
