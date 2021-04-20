//
//  DateAtual.swift
//  BitBeca
//
//  Created by Elisa Camillo on 17/04/21.
//

import UIKit

class DateAtual: NSObject {
// // MARK: - Funcção para gerar a data atual
      func getCurrentDateTime() -> String {
          let data = Date()
          let formatter = DateFormatter()
          formatter.locale = Locale(identifier: "pt_BR")
          formatter.dateFormat = "dd MMMM YYYY"
          let result = formatter.string(from: data)
          return result
      }
}
