//
//  BitBecaTests.swift
//  BitBecaTests
//
//  Created by Renilson Moreira Ferreira on 13/04/21.
//

import XCTest
@testable import BitBeca
import Alamofire

class BitBecaTests: XCTestCase {
    
    var viewController: ViewController!

    override func setUp() {
        super.setUp()
        viewController = ViewController()
        viewController.getDataCriptomoedas()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testApi() {
        
        let expectation = XCTestExpectation(description: "Teste para api CoinAPI")

        let api_key: String = "1F8A5E86-F1C9-41C7-B8BB-9DB1B81FDE7C"
        
        let url = URL(string: "https://rest.coinapi.io/v1/assets/?apikey=\(api_key)")!

        Alamofire.request(url)
            .response { data in
                XCTAssertNotNil(data, "Nenhum dado foi baixado")
                expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2000.0)

    }
    
    
    func testDeveRetornarPrimeiraSiglaDaChamadaDaApi(){
        let lista = viewController.listaCriptoViewModel
        guard let sigla = lista.first?.sigla else {return}
        XCTAssertEqual(sigla, "BTC")
    }
    
    

}
