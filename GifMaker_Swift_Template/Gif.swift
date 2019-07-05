//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Tanin on 05/07/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class Gif:NSObject {
  let url: URL
  let videoURL: URL
  let caption: String?
  var gifImage: UIImage?
  var gifData: NSData?
  
  init(url:URL, videoURL: URL, caption: String?) {
    
    self.url = url
    self.videoURL = videoURL
    self.caption = caption
    self.gifImage = UIImage.gif(url: url.absoluteString)!
    self.gifData = nil
  }
  
  func set(_ name: String){
    self.gifImage = UIImage.gif(name: name)
  }
}
