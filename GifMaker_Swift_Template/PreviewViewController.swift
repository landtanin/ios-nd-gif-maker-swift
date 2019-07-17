//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Tanin on 13/06/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit
import QuartzCore

class PreviewViewController: UIViewController {
  
  @IBOutlet weak var gifImageView: UIImageView!
  @IBOutlet weak var shareButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  
  var gif:Gif? = nil

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = "Preview"
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.gifImageView.image = self.gif?.gifImage
    
    // Customise Buttons
    self.shareButton.layer.cornerRadius = 4.0
    self.shareButton.layer.borderColor = UIColor(red: 255.0/255.0, green: 65.0/255.0, blue: 112.0/255.0, alpha: 1.0).cgColor
    self.shareButton.layer.borderWidth = 1.0
    
    self.saveButton.layer.cornerRadius = 4.0
  }
  
  
  @IBAction func shareGif(sender: AnyObject) {
    let url: URL = (self.gif?.url)!
    let animatedGIF = NSData(contentsOf: url)
    let itemsToShare = [animatedGIF]
    
    let activityVC = UIActivityViewController(activityItems: itemsToShare as [Any], applicationActivities: nil)
    
    activityVC.completionWithItemsHandler = {(activity, completed, items, error) in
      if (completed) {
        self.navigationController?.popToRootViewController(animated: true)
      }
    }
    
    navigationController?.present(activityVC, animated: true, completion: nil)
  }
  
}
