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
    let myImage = BitcoinsTableViewCell()

    @IBOutlet weak var myLabelData: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        cores(cor: .corBlack)
        myProvider.getData()
        getCurrentDateTime()
        self.tableBitcoins.dataSource = self
        self.tableBitcoins.backgroundColor = .black
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
        return 40
    }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellBitcoin", for: indexPath) as! BitcoinsTableViewCell
                // MARK: - Chamar o array
                cell.labelNameBitcoin.text = "Titulo"
                cell.labelSiglaBitcoin.text = "sigla"
                cell.labelPriceBitcoin.text = "R$31,000,00"
                return cell
            }
       }
