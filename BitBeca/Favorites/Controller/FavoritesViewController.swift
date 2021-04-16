// FavoritesViewController.swift
// BitBeca

// Created by Renilson Moreira Ferreira on 15/04/21.

 import UIKit

 class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    //viewDidLoad
    //ViewDidLoad2
    override func viewDidLoad() {
        super.viewDidLoad()

        myCollectionView.dataSource = self
        myCollectionView.delegate = self

    }
    // MARK: - CollectionView Favorites
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20    }
    // MARK: - Conteudo da linha
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellFavorites = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavorites", for: indexPath) as? ListaFavoritesCollectionViewCell
        return cellFavorites!

    }
 }
