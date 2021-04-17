// FavoritesViewController.swift
// BitBeca

// Created by Renilson Moreira Ferreira on 15/04/21.

 import UIKit

 class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        // viewAuxiliar.layer.cornerRadius = 8

    }
    // MARK: - CollectionView Favorites
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200    }
    // MARK: - Conteudo da linha
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellFavorites = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavorites", for: indexPath) as? ListaFavoritesCollectionViewCell
        return cellFavorites!

    }
 }
