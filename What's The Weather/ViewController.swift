//
//  ViewController.swift
//  What's The Weather
//
//  Created by Nadeem Ansari on 5/2/17.
//  Copyright © 2017 Nadeem Ansari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var submitBTN: UIButton!
    
    @IBOutlet weak var outputLBL: UILabel!
    
    @IBOutlet weak var cityTF: UITextField!
    
    @IBAction func submitBTN(_ sender: Any) {
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/"+cityTF.text!.replacingOccurrences(of: " ", with: "-")+"/forecasts/latest") {
            let request = NSMutableURLRequest(url: url)
            var message = ""
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (Data, Response, Error) in
                
                if Error != nil {
                    print(Error!)
                }
                else {
                    if Data != nil {
                        let unwrappedData = Data!
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        let stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                                                       
                            if (contentArray.count) > 1 {
                                
                                let potentialOutput = contentArray[1]
                                
                                let finalOutput = potentialOutput.components(separatedBy: "</span>")
                                
                                if finalOutput.count > 1 {
                                    message = finalOutput[0].replacingOccurrences(of: "&deg;", with: "\u{00B0}")
                                    
                                    print(message)
                                }
                            }
                        }
                    }
                }
                
                if message == "" {
                    message = "The weather couldn't be found. Try again later."
                }
                DispatchQueue.main.sync(execute: {
                    
                    self.outputLBL.isHidden = false
                    self.outputLBL.text = message
                    
                })
            }
            task.resume()
        }
        else {
            outputLBL.text = "Error"
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        submitBTN.layer.cornerRadius = 5
        outputLBL.layer.masksToBounds = true
        outputLBL.layer.cornerRadius = 5
        outputLBL.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

