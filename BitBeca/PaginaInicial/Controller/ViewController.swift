//
//  ViewController.swift
//  BitBeca
//
//  Created by Renilson Moreira Ferreira on 13/04/21.
//

import UIKit
import Commons
import Details

// teste

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
class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableBitcoins: UITableView!
    let myProvider = CriptomoedaProvider()

    @IBOutlet weak var myLabelData: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        cores(cor: .corBlack)
        getCurrentDateTime()
        self.tableBitcoins.dataSource = self
        self.tableBitcoins.backgroundColor = .black
        myProvider.getData()
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

    // MARK: - TableView Tela Principal
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DispatchQueue.main.async {
         self.tableBitcoins.reloadData()
        }
        return myProvider.listaCriptoViewModel.count
    }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellBitcoin", for: indexPath) as! BitcoinsTableViewCell
                // MARK: - Chamar o array
               cell.labelNameBitcoin.text = myProvider.listaCriptoViewModel[indexPath.row].name
               cell.labelSiglaBitcoin.text = myProvider.listaCriptoViewModel[indexPath.row].sigla
               cell.labelPriceBitcoin.text = String(myProvider.listaCriptoViewModel[indexPath.row].price)
               let idIcon = myProvider.listaCriptoViewModel[indexPath.row].idIcon
               let id = idIcon.replacingOccurrences(of: "-", with: "")
               cell.getIcon(idIcon: id)
               return cell

            }
       }
