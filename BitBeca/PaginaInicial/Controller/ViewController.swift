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
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    let defaults = UserDefaults.standard
    let dataAtual = DateAtual()
    let myProvider = CriptomoedaProvider()
    var listaCriptoViewModel: [CriptoViewModel]=[]
    var filteredList: [CriptoViewModel] = []
    var localArray: [String] = []
    var testeIsFav: Bool = false

    // MARK: - IBOutlets

    @IBOutlet weak var pesquisarCriptomoedas: UISearchBar!
    @IBOutlet weak var tableBitcoins: UITableView!
    @IBOutlet weak var myLabelData: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        cores(cor: .corBlack)
        self.tableBitcoins.dataSource = self
        self.tableBitcoins.delegate = self
        self.tableBitcoins.backgroundColor = .black
        getDataCriptomoedas()
        myLabelData.text = dataAtual.getCurrentDateTime()
        pesquisarCriptomoedas.delegate = self

        guard let arrayFav = defaults.array(forKey: "arrayFav") else {
            defaults.setValue(localArray, forKey: "arrayFav")
            return
        }

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
            }
            DispatchQueue.main.async {
                self.tableBitcoins.reloadData()
            }
            self.filteredList = self.listaCriptoViewModel
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        tableBitcoins.reloadData()
        print("didappear")
    }

    // MARK: - TableView Tela Principal
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBitcoin", for: indexPath) as! BitcoinsTableViewCell

        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.0392, green: 0.4078, blue: 0, alpha: 1)
        cell.selectedBackgroundView = backgroundView

        // siglaCell é igual a sigla dessa célula
        let siglaCell = self.filteredList[indexPath.row].sigla

        // pegando o array de favoritos do userdefaults
        let arrayFav = defaults.array(forKey: "arrayFav") as! [String]

        // se o array de favoritos contém a sigla dessa célula, adiciona a imagem de favorito; se não contém, retira a imagem
        if arrayFav.contains(siglaCell) {
            cell.iconFavorite.image = UIImage(named: "iconFav")
        } else {
            cell.iconFavorite.image = nil
        }

        cell.labelNameBitcoin.text = filteredList[indexPath.row].name
        cell.labelSiglaBitcoin.text = filteredList[indexPath.row].sigla
        cell.labelPriceBitcoin.text = ("$ \(String(format: "%.2f", self.filteredList[indexPath.row].price))")
        let idIcon = filteredList[indexPath.row].idIcon
        let id = idIcon.replacingOccurrences(of: "-", with: "")
        cell.getIcon(idIcon: id)
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let siglaDetalhes = listaCriptoViewModel[indexPath.row].sigla

        DispatchQueue.main.async {
            let sb = UIStoryboard(name: "Details", bundle: DetailsViewController.bundleUI)
            if let vc = sb.instantiateViewController(withIdentifier: "DetailsID") as? DetailsViewController {
                vc.sigla = siglaDetalhes
                vc.loadViewIfNeeded()
            self.navigationController?.pushViewController(vc, animated: true)

            }

        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredList = []
        if searchText == ""{
            filteredList = listaCriptoViewModel
        } else {
            for cripto in listaCriptoViewModel {

                if cripto.name.lowercased().contains(searchText.lowercased()) {
                    filteredList.append(cripto)
                }

            }
        }

        self.tableBitcoins.reloadData()

      }
}
