// FavoritesViewController.swift
// BitBeca
// Created by Renilson Moreira Ferreira on 15/04/21.
import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myDateFavorites: UILabel!

    let dataAtual = DateAtual()
    let defaults = UserDefaults.standard
    var localArray: [String] = []
    public var teste: [CriptoViewModel] = []
    var arrayCollectionFavorites: [CriptoViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        myDateFavorites.text = dataAtual.getCurrentDateTime()
        guard let arrayFav = defaults.array(forKey: "arrayFav") as? [String] else {
            defaults.setValue(localArray, forKey: "arrayFav")
            return
        }
        print(arrayFav)
        var sharedArray = AppModel.sharedInstance.sharedArray
        getDataListaFavoritos(arrayFav: arrayFav, arrayCripto: sharedArray!)

    }

    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
                    self.myCollectionView.reloadData()

                }
    }

    override func viewWillAppear(_ animated: Bool) {

    }

    func getDataListaFavoritos(arrayFav: [String], arrayCripto: [CriptoViewModel]) {

        for i in 0...arrayCripto.count-1 {
            let sigla = arrayCripto[i].sigla
            if arrayFav.contains(sigla) {
                arrayCollectionFavorites.append(arrayCripto[i])
                myCollectionView.reloadData()
            }
        }
        print("testeeee \(arrayCollectionFavorites)")

    }
    // MARK: - CollectionView Favorites
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCollectionFavorites.count

    }

    // MARK: - Conteudo da linha
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellFavorites = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavorites", for: indexPath) as? ListaFavoritesCollectionViewCell
        cellFavorites?.labelNomeBitcoin.text = arrayCollectionFavorites[indexPath.item].name
        cellFavorites?.labelSiglaBitcoin.text = arrayCollectionFavorites[indexPath.item].sigla
        cellFavorites?.labelPriceBitcoin.text = ("$ \(String(format: "%.2f", self.arrayCollectionFavorites[indexPath.item].price))")
        let idIcon = arrayCollectionFavorites[indexPath.item].idIcon
        let id = idIcon.replacingOccurrences(of: "-", with: "")
        cellFavorites?.getIcon(idIcon: id)

        return cellFavorites!
    }
    // MARK: - Layout da collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let larguraCell = collectionView.bounds.width / 2
        return CGSize(width: larguraCell-15, height: 160)
    }

}
