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


}

