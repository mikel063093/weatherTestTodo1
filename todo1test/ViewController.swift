//
//  ViewController.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbHumidity: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblRain: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbHumidity.text = "alv perr"
    }

    @IBAction func refresh(_ sender: Any) {
    }
    
}

