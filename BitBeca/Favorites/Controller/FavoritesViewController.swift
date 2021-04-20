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

    override func viewDidLoad() {
        super.viewDidLoad()

        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        myDateFavorites.text = dataAtual.getCurrentDateTime()

        guard let currentFavs = defaults.array(forKey: "arrayFav") else {
            defaults.setValue(localArray, forKey: "arrayFav")
            return
        }

        print(currentFavs)
        myCollectionView.reloadData()

        var listaFavoritos = AppModel.sharedInstance.sharedArray
        guard let numero = listaFavoritos?.count else {return}
        print(numero)
    }

    override func viewDidAppear(_ animated: Bool) {

    }

    // MARK: - CollectionView Favorites
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10    }

    // MARK: - Conteudo da linha
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellFavorites = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavorites", for: indexPath) as? ListaFavoritesCollectionViewCell
        cellFavorites?.labelNomeBitcoin.text = "Moeda"
        cellFavorites?.labelSiglaBitcoin.text = "sigla"
        cellFavorites?.labelPriceBitcoin.text = "R$ 31,000,00"
        // cellFavorites?.imageIcon.image = ""
        return cellFavorites!
    }
    // MARK: - Layout da collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let larguraCell = collectionView.bounds.width / 2
        return CGSize(width: larguraCell-15, height: 160)
    }
}
