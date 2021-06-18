//
//  ViewController.swift
//  RESTRequests
//
//  Created by Леонид on 18.06.2021.
//

import UIKit

class mainPageVC: UIViewController {
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var postURL: UIButton!
    @IBOutlet weak var getURL: UIButton!
    @IBOutlet weak var postAlamofire: UIButton!
    @IBOutlet weak var getAlamofire: UIButton!
    
    let urlNetworkingObj = URLNetworking()
    let afNetworkingObj = AlamofireNetworking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTextView.layer.borderWidth = 1.0
        resultTextView.layer.borderColor = UIColor.black.cgColor
        resultTextView.layer.cornerRadius = 5.0
        postURL.layer.cornerRadius = 5.0
        getURL.layer.cornerRadius = 5.0
        postAlamofire.layer.cornerRadius = 5.0
        getAlamofire.layer.cornerRadius = 5.0
    }
    @IBAction func postRequestURL(_ sender: UIButton) {
        self.urlNetworkingObj.postRequest { result in
            self.resultTextView.text = result
        }
    }
    
    @IBAction func getRequestURL(_ sender: UIButton) {
        self.urlNetworkingObj.getRequest { result in
            self.resultTextView.text = result
        }
    }
    
    @IBAction func postRequestAF(_ sender: UIButton) {
        self.afNetworkingObj.postRequest { result in
            self.resultTextView.text = result
        }
    }
    
    @IBAction func getRequestAF(_ sender: UIButton) {
        self.afNetworkingObj.getRequest { result in
            self.resultTextView.text = result
        }
    }
}

