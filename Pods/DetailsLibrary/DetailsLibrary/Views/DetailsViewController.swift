//
//  DetailsViewController.swift
//  DetailsLibrary
//
//  Created by Elisa Camillo on 15/04/21.
//

import UIKit

public class DetailsViewController: UIViewController {
    
    @IBOutlet weak var coinAbbreviation: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinValue: UILabel!
    @IBOutlet weak var favoritesButton: UIView!
    @IBOutlet weak var lastHour: UILabel!
    @IBOutlet weak var lastDay: UILabel!
    @IBOutlet weak var lastMonth: UILabel!
    
    var teste: String = ""
    var isFavorite: Bool = false
    let defaults = UserDefaults.standard
    var arrayOfFav:[String] = []
    @IBOutlet weak var button: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewDidLayoutSubviews(){
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)

    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // recuperando o array de favoritos
        let savedArray = defaults.object(forKey: "arrayTeste") as? [String]
        arrayOfFav = savedArray!
        print(arrayOfFav)
        
        // se o array contém essa moeda, título do botão muda
        if let bool = savedArray?.contains("mais outro favorito") {
            if(bool == true) {
                button.setTitle("REMOVER", for: .normal)
                isFavorite = true
            }
        }
    }
    
    
    @IBAction func addOrRemove(_ sender: Any) {
        if(isFavorite) {
            if let index = arrayOfFav.firstIndex(of: "mais um outro favorito") {
                arrayOfFav.remove(at: index)
                defaults.setValue(arrayOfFav, forKey: "arrayTeste")
            }
            button.setTitle("ADICIONAR", for: .normal)
            
        } else {
            arrayOfFav.append("outro favorito")
            defaults.setValue(arrayOfFav, forKey: "arrayTeste")
            viewWillAppear(true)
        }
    }
    
    
    public func testando(stringTeste:String) {
        print("*****************************##################*******")
        print(stringTeste)
        DispatchQueue.main.async {
            self.coinAbbreviation?.text = stringTeste
           }
        print("*****************************##################*******")

    }
    
}

extension UIViewController {
    public static var bundleUI: Bundle {
        var bundle: Bundle
        if let bundeLet = Bundle(identifier: "com.br.everis.DetailsLibrary") {
            bundle = bundeLet
        } else {
            bundle = Bundle(for: self)
        }
        return bundle
    }
    public class func fromSB() -> Self {
        return fromSB(viewType: self)
    }
    public class func fromSB<T: UIViewController>(viewType: T.Type) -> T {
        let sb = UIStoryboard(name: "Details", bundle: bundleUI)
        if let vc = sb.instantiateViewController(withIdentifier: "DetailsID") as? T {
            vc.loadViewIfNeeded()
            return vc
        }
        return T()
    }
}

public class loadStory: UIViewController {
    public static func execLoad() -> UIViewController {
        if let bundle = Bundle(identifier: "com.br.everis.DetailsLibrary") {
            let sb = UIStoryboard(name: "Details", bundle: bundle)
            let vc = sb.instantiateViewController(withIdentifier: "DetailsID") as! DetailsViewController
            vc.loadViewIfNeeded()
            return vc
        } else {
            return UIViewController()
        }
        
    }
    
}
