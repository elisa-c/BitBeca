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
    
    public var sigla: String = "valor inicializado no módulo"
    public var isFavorite: Bool = false
    let defaults = UserDefaults.standard
    var localArray:[String] = []
    @IBOutlet weak var button: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
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
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 8
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true


        // recuperando o array de favoritos
        guard let savedArray = defaults.object(forKey: "arrayFav") as? [String] else {
            defaults.setValue(localArray, forKey: "arrayFav")
            return
        }
        
        localArray = savedArray
        
        // se o array contém essa moeda, título do botão muda
        if (savedArray.contains(sigla)) {
                button.setTitle("REMOVER", for: .normal)
                isFavorite = true
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    public init(sigla: String) {
        super.init(nibName: nil, bundle: nil)
        self.sigla = sigla
    }

    public override func viewDidAppear(_ animated: Bool) {

        let provider = DetailsAPI()
        
        provider.getDetails(abrevDetails: sigla, completion: {(result) in
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

                let baseURL = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_64/\(newIconID).png"
                guard let imageURL = URL(string: baseURL) else {return}
                self.coinImage.af_setImage(withURL: imageURL)

            }

        })
    }
    
    
    
    public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    
    
    @IBAction func addOrRemove(_ sender: Any) {
        
        if(isFavorite) {
            if let index = localArray.firstIndex(of: sigla) {
                localArray.remove(at: index)
                defaults.setValue(localArray, forKey: "arrayFav")
            }
            button.setTitle("ADICIONAR", for: .normal)
          

        } else {
            localArray.append(sigla)
            defaults.setValue(localArray, forKey: "arrayFav")
            viewWillAppear(true)
        }
        print(defaults.array(forKey: "arrayFav")!)
        
    }
    
    
}
