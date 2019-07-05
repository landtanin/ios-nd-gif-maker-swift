//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Tanin on 13/06/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController {
  
  @IBOutlet weak var gifImageView: UIImageView!
  @IBOutlet weak var captionTextField: UITextField!
  var gif:Gif?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let gif = gif {
      gifImageView.image = gif.gifImage
    }
  }
  
}
