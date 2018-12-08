//
//  DadosViewController.swift
//  Ipiranga
//
//  Created by Maurício Mazzocco on 07/12/18.
//  Copyright © 2018 Totvs. All rights reserved.
//

import UIKit

class DadosViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var selectedFuel : String!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        //or
        //self.view.endEditing(true)
        return true
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (row == 0){
            return "Disel"
        }
        if (row == 1){
            return "Gasolina"
        }
            return "Aloccol"

    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (row == 0){
             selectedFuel =  "Disel"
        }
        if (row == 1){
            selectedFuel = "Gasolina"
        }
         selectedFuel =  "Aloccol"

    }

    @IBOutlet weak var kmAtualTxt: UITextField!
    @IBOutlet weak var valorTotalTxt: UITextField!
    @IBOutlet weak var qtdLitrosTxt: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var postoTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func getQtdLitros() -> String{
        return qtdLitrosTxt.text!
    }

    func getValorTotalTxt() -> String{
        return valorTotalTxt.text!
    }

    func getPosto() -> String{
        return postoTxt.text!
    }

    func getKmAtualTxt() -> String{
        return kmAtualTxt.text!
    }

    func getTipoCombustivel() -> String{
        return selectedFuel
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        kmAtualTxt.delegate = self
        valorTotalTxt.delegate = self
        qtdLitrosTxt.delegate = self
        postoTxt.delegate = self
        selectedFuel =  "Disel"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
     
    }




    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
       self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
