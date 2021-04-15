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
class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableBitcoins: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cores(cor: .corBlack)
        self.tableBitcoins.dataSource = self
        self.tableBitcoins.backgroundColor = .black
    }
    // MARK: - Cores
    func cores(cor: CoresBitBeca) {
        self.view.backgroundColor = cor.corSelecionada
    }
    // MARK: - TableView Tela Principal
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBitcoin", for: indexPath)
        return cell
    }
}
