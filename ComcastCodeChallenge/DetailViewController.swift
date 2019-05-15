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

    @IBOutlet weak var textViewOutlet: UITextView!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        
        if let object_ = self.object {
        
            self.titleLabelOutlet.text = object_.title
            self.textViewOutlet.text = object_.description
            
            if let url = object_.urlImage, url != "" {
                
                let apicaller = API_Caller(URL: url, httpMethodType: .GET, authenticationType: .None)
                apicaller.callAPI(dataParameter: nil, customHeaders: nil) {
                    
                    [weak self] (status,data,response) in
                    
                        if let data_ = data as? Data {
                        
                            let image = UIImage(data: data_)
                        
                            DispatchQueue.main.async {
                            
                                self?.imageViewOutlet.backgroundColor = .white
                                self?.imageViewOutlet.image = image
                            }
                        
                        } else { //Not Data
                        
                            self?.imageViewOutlet.backgroundColor = .clear
                    }
                }
            } else { //Not URL
                
                self.imageViewOutlet.backgroundColor = .clear
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    

}

