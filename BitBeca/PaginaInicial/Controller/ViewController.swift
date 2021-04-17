//
//  ViewController.swift
//  BitBeca
//
//  Created by Renilson Moreira Ferreira on 13/04/21.
//
import UIKit
import Commons
import Details

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
    @IBOutlet weak var tableBitcoins: UITableView!
    let myProvider = CriptomoedaProvider()
    var listaCriptoViewModel: [CriptoViewModel]=[]
    @IBOutlet weak var myLabelData: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        cores(cor: .corBlack)
        getCurrentDateTime()
        self.tableBitcoins.dataSource = self
        self.tableBitcoins.backgroundColor = .black
        getDataCriptomoedas()
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
        cell.labelNameBitcoin.text = listaCriptoViewModel[indexPath.row].name
        cell.labelSiglaBitcoin.text = listaCriptoViewModel[indexPath.row].sigla
        cell.labelPriceBitcoin.text = ("$ \(String(format: "%.2f", self.listaCriptoViewModel[indexPath.row].price))")
        let idIcon = listaCriptoViewModel[indexPath.row].idIcon
        let id = idIcon.replacingOccurrences(of: "-", with: "")
        cell.getIcon(idIcon: id)
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("sometghion")
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("jjjj")
    }
}
