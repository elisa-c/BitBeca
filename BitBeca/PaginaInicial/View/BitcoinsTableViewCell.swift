//
//  BitcoinsTableViewCell.swift
//  BitBeca
//
//  Created by Renilson Moreira Ferreira on 16/04/21.
//

import UIKit
import AlamofireImage

class BitcoinsTableViewCell: UITableViewCell {
    @IBOutlet weak var myImageBitcoin: UIImageView!
        @IBOutlet weak var labelNameBitcoin: UILabel!
        @IBOutlet weak var labelSiglaBitcoin: UILabel!
        @IBOutlet weak var labelPriceBitcoin: UILabel!

    func getIcon(idIcon: String) {
        let urlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_64/\(idIcon).png"
        guard let urlImagem = URL(string: urlString) else {return}
        myImageBitcoin.af_setImage(withURL: urlImagem)
    }

}
