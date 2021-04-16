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

class ViewController: UIViewController {
    let myProvider = CriptomoedaProvider()
    override func viewDidLoad() {
        super.viewDidLoad()
        cores(cor: .corBlack)
        myProvider.getData()
    }

    // MARK: - Cores
    func cores(cor: CoresBitBeca) {
        self.view.backgroundColor = cor.corSelecionada
    }
}
