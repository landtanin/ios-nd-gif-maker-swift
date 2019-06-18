//
//  WelcomeViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Tanin on 13/06/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  @IBOutlet weak var gifImageView: UIImageView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let spikeGif = UIImage.gif(name: "hotlineBling")
    gifImageView.image = spikeGif
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  
}
