//
//  ListaFavoritesCollectionViewCell.swift
//  BitBeca
//
//  Created by Renilson Moreira Ferreira on 15/04/21.
//
import UIKit
import AlamofireImage

class ListaFavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelNomeBitcoin: UILabel!
    @IBOutlet weak var labelSiglaBitcoin: UILabel!
    @IBOutlet weak var labelPriceBitcoin: UILabel!

    func getIcon(idIcon: String) {
        let urlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_64/\(idIcon).png"
        guard let urlImagem = URL(string: urlString) else {return}
        imageIcon.af_setImage(withURL: urlImagem)
    }

}
