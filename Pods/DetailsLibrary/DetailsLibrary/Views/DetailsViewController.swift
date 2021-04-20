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
        print(teste)
        print("sigla no viewDidLoad: \(sigla)")
        print("self.sigla no viewDidLoad: \(self.sigla)")
        print("--------------")

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
        print(teste)
        self.sigla = sigla
        print("--------------")
        print("sigla no init: \(sigla)")
        print("self.sigla no init: \(self.sigla)")
        print("--------------")
        
    }

    
    public override func viewDidAppear(_ animated: Bool) {

        let provider = DetailsAPI()
        let a = "PLN"
        print(teste)
        print("self.sigla didappear: \(self.sigla)")

        
        provider.getDetails(abrevDetails: teste, completion: {(result) in
            DispatchQueue.main.async {
                print("--------------")
                print("viewDidAppear dispatchQueue")
                self.coinAbbreviation?.text = result.abbreviation!
                self.coinValue?.text = String(format: "%.2f", result.priceUsd!)
                self.lastHour?.text = String(format: "%.2f", result.volume1HrsUsd!)
                self.lastDay?.text = String(format: "%.2f", result.volume1DayUsd!)
                self.lastMonth?.text = String(format: "%.2f", result.volume1MthUsd!)
                let newIconID = result.idIcon!.replacingOccurrences(of: "-", with: "")

                let baseURL = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_32/\(newIconID).png"
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

