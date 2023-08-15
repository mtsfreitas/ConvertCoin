//
//  CoinConverterController.swift
//  ConvertCoin
//
//  Created by Matheus Freitas Martins on 14/08/23.
//

import UIKit
import iOSDropDown

class CoinConverterController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var dropDownFrom: DropDown!
    @IBOutlet weak var dropDownTo: DropDown!
    @IBOutlet weak var lblValueConverted: UILabel!
    @IBOutlet weak var txtValueInfo: UITextField!
    
    //MARK: ViewModel
    private var viewModel: CoinConverterViewModel!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CoinConverterViewModel()
        self.configDropDown()
      
        // Do any additional setup after loading the view.
    }
    
    //MARK: @IBActions
    @IBAction func actGetCoin(_ sender: UIButton) {
        let error: String = self.validateFields()
        if error != String.empty() {
            self.view.showMessage(view: self, message: error)
        } else {
            let param1 = self.dropDownFrom.text!
            let param2 = self.dropDownTo.text!
            
            let param: String = "\(param1)-\(param2)"
            self.getCoins(param: param)
        }
    }
    
    //MARK: Private Funcs
    private func validateFields() -> String {
        var error: String = String.empty()
        
        if self.txtValueInfo.text == String.empty() {
            error = "informe um valor a ser convertido"
        } else if self.dropDownTo.text == String.empty() || self.dropDownFrom.text == String.empty() {
            error = "selecione as moedas a serem convertidas"
        } else if self.dropDownTo.text == self.dropDownFrom.text {
            error = "selecione moedas diferentes"
        }
        return error
    }
    
    private func getCoins(param: String) {
        self.viewModel.getCoins(params: param) { (data, error) in
            if let coins = data {
                DispatchQueue.main.async {
                    let valueStr: NSNumber = self.viewModel.calculatedCoins(valueInfo: self.txtValueInfo.text!, valueCoin: coins.first!.value.buyValue)
                    self.lblValueConverted.text = String().formatCurrency(value: valueStr, enumCoin: self.dropDownTo.text!)
                }
            } else {
              
            }
        }
    }
    
    
    private func configDropDown() {
        self.dropDownTo.optionArray = self.viewModel.getListCoins()
        self.dropDownTo.arrowSize = 9
        self.dropDownTo.selectedRowColor = .gray
        
        self.dropDownFrom.optionArray = self.viewModel.getListCoins()
        self.dropDownFrom.arrowSize = 9
        self.dropDownFrom.selectedRowColor = .gray
    }
}
