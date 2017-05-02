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
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        submitBTN.layer.cornerRadius = 5
        outputLBL.layer.masksToBounds = true
        outputLBL.layer.cornerRadius = 5
        outputLBL.isHidden = true
        
        let url = URL(string: "http://www.weather-forecast.com/locations/London/forecasts/latest")
        let request = NSMutableURLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (Data, Response, Error) in
            
            if Error != nil {
                print(Error!)
            }
            else {
                if Data != nil {
                    let unwrappedData = Data!
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    print(dataString!)
                }
            }
            
        }
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

