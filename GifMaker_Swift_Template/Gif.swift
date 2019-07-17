//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Tanin on 05/07/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class Gif:NSObject {
  var url: URL?
  var videoURL: URL?
  var caption: String?
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
  
  //MARK: PErsistence methods
  // archive retrieval
  required init?(coder aDecoder: NSCoder) {
    self.url = aDecoder.decodeObject(forKey: "url") as! URL?
    self.videoURL = aDecoder.decodeObject(forKey: "videoURL") as! URL?
    self.caption = aDecoder.decodeObject(forKey: "caption") as! String?
    self.gifImage = aDecoder.decodeObject(forKey: "gifImage") as? UIImage
    self.gifData = aDecoder.decodeObject(forKey: "gifData") as! NSData?
    
  }
  //archiver
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.url, forKey: "url")
    aCoder.encode(self.videoURL, forKey: "videoURL")
    aCoder.encode(self.caption , forKey: "caption")
    aCoder.encode(self.gifData, forKey: "gifData")
    aCoder.encode(self.gifImage, forKey: "gifImage")
  }
}
