//
//  DetailViewController.swift
//  ComcastCodeChallenge
//
//  Created by Eladio Alvarez Valle on 5/14/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var object : CharacterModel?

    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var detailLabelOutlet: UILabel!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        
        if let object_ = self.object {
        
            self.titleLabelOutlet.text = object_.title
            self.detailLabelOutlet.text = object_.description
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

}

