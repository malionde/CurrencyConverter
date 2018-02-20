//
//  ViewController.swift
//  Currency
//
//  Created by Mehmet Ali Önde on 19.02.2018.
//  Copyright © 2018 Mehmet Ali Önde. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var myCurrency:[String]=[]
    var myValues:[Double]=[]
    var activeCurrency:Double = 0;
    //var currencyType:[String]=[]
    
    //OBJECTS
    
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //CREATING PICKER VIEW
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        return myCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return myCurrency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        activeCurrency = myValues[row]
    }
    
    //BUTTON
    @IBAction func action(_ sender: AnyObject)
    {
        if (input.text != "")
        {
            output.text = String(Double(input.text!)! * activeCurrency)
        }
    }
    
    
    override func viewDidLoad() {
        
        //Gettin Data from API
       // currencyType = [type.text!]
        let url = URL(string: "http://api.fixer.io/latest?base=TRY")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("ERROR")
            }
            else{
                if let content = data {
                    do{
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for (key, value) in rates
                            {
                                self.myCurrency.append((key as! String))
                                self.myValues.append((value as! Double))
                            }
                            //print (self.myCurrency)
                            //print (self.myValues)
                        }
                    }
                    catch{
                    }
                }
            }
            self.pickerView.reloadAllComponents()
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
}

