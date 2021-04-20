//
//  DetailsViewController.swift
//  DetailsLibrary
//
//  Created by Elisa Camillo on 15/04/21.
//

import UIKit
import AlamofireImage

public class DetailsViewController: UIViewController {
    
    @IBOutlet weak var coinAbbreviation: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinValue: UILabel!
    @IBOutlet weak var favoritesButton: UIView!
    @IBOutlet weak var lastHour: UILabel!
    @IBOutlet weak var lastDay: UILabel!
    @IBOutlet weak var lastMonth: UILabel!
    
    public var teste: String = "valor inicial"
    var sigla: String = "valor inicializado no módulo"
    var isFavorite: Bool = false
    let defaults = UserDefaults.standard
    var arrayOfFav:[String] = []
    @IBOutlet weak var button: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public static var bundleUI: Bundle {
            var bundle: Bundle
            if let bundeLet = Bundle(identifier: "com.br.everis.DetailsLibrary") {
                bundle = bundeLet
            } else {
                bundle = Bundle(for: self)
            }
            return bundle
        }
    
    public override func viewDidLayoutSubviews(){

        // modificações no layout vão aqui
    }

//    public override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//        // recuperando o array de favoritos
//        let savedArray = defaults.object(forKey: "arrayTeste") as? [String]
//        arrayOfFav = savedArray!
//        print(arrayOfFav)
//
//        // se o array contém essa moeda, título do botão muda
//        if let bool = savedArray?.contains("mais outro favorito") {
//            if(bool == true) {
//                button.setTitle("REMOVER", for: .normal)
//                isFavorite = true
//            }
//        }
//    }
    
    public init(sigla: String) {
        super.init(nibName: nil, bundle: nil)
        self.sigla = sigla
    }

    
    public override func viewDidAppear(_ animated: Bool) {

        let provider = DetailsAPI()
        
        provider.getDetails(abrevDetails: teste, completion: {(result) in
            DispatchQueue.main.async {
                
                self.coinAbbreviation?.text = result.abbreviation!
                
                guard let price = result.priceUsd else {return}
                self.coinValue?.text = ("$ \(String(format: "%.2f", price))")
        
                guard let lastHour = result.volume1HrsUsd else {return}
                self.lastHour?.text = ("$ \(String(format: "%.2f", lastHour))")
                
                guard let lastDay = result.volume1DayUsd else {return}
                self.lastDay?.text = ("$ \(String(format: "%.2f", lastDay))")
                
                guard let lastMonth = result.volume1MthUsd else {return}
                self.lastMonth?.text = ("$ \(String(format: "%.2f", lastMonth))")
                
                let newIconID = result.idIcon!.replacingOccurrences(of: "-", with: "")

                let baseURL = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_16/\(newIconID).png"
                guard let imageURL = URL(string: baseURL) else {return}
                self.coinImage.af_setImage(withURL: imageURL)

            }

        })
    }
    
    
    
    public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    
    
//    @IBAction func addOrRemove(_ sender: Any) {
//        if(isFavorite) {
//            if let index = arrayOfFav.firstIndex(of: "mais um outro favorito") {
//                arrayOfFav.remove(at: index)
//                defaults.setValue(arrayOfFav, forKey: "arrayTeste")
//            }
//            button.setTitle("ADICIONAR", for: .normal)
//
//        } else {
//            arrayOfFav.append("outro favorito")
//            defaults.setValue(arrayOfFav, forKey: "arrayTeste")
//            viewWillAppear(true)
//        }
//    }
    
    
}
//
//extension UIViewController {
//    public static var bundleUI: Bundle {
//        var bundle: Bundle
//        if let bundeLet = Bundle(identifier: "com.br.everis.DetailsLibrary") {
//            bundle = bundeLet
//        } else {
//            bundle = Bundle(for: self)
//        }
//        return bundle
//    }
//    public class func fromSB() -> Self {
//        return fromSB(viewType: self)
//    }
//    public class func fromSB<T: UIViewController>(viewType: T.Type) -> T {
//        let sb = UIStoryboard(name: "Details", bundle: bundleUI)
//        if let vc = sb.instantiateViewController(withIdentifier: "DetailsID") as? T {
//            vc.loadViewIfNeeded()
//            return vc
//        }
//        return T()
//    }
//}

