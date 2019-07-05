//
//  UIViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Tanin on 13/06/2019.
//  Copyright © 2019 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

// Regift constants
let frameCount = 16
let delayTime: Float = 0.2
let loopCount = 0

extension UIViewController: UINavigationControllerDelegate {
  
  @IBAction func presentVideoOptions(sender: AnyObject) {
    
    // create imagePicker
    // set properties: sourcetype, mediatype, allowsEditing, delegate
    // present controller
    let recordVideoController = UIImagePickerController()
    recordVideoController.sourceType = .camera
    recordVideoController.mediaTypes = [kUTTypeMovie as String]
    recordVideoController.allowsEditing = false
    recordVideoController.delegate = self
    
    present(recordVideoController, animated: true, completion: nil)
    
  }
  
}

extension UIViewController: UIImagePickerControllerDelegate {
  
  public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    let mediaType = info[UIImagePickerControllerMediaType] as! String
    
    if mediaType == kUTTypeMovie as String {
      let videoURL = info[UIImagePickerControllerMediaURL] as! URL
      dismiss(animated: true, completion: nil)
//      UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path!, nil, nil, nil)
      convertVideoToGif(videoURL: videoURL as URL)
    }
    
    
  }
  
  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  // GIF conversion methods
  public func convertVideoToGif(videoURL: URL) {
    let regift = Regift(sourceFileURL: videoURL, frameCount: frameCount, delayTime: delayTime)
    let gifURL = regift.createGif()
    let gif = Gif(url: gifURL!, videoURL: videoURL, caption: nil)
    display(gif)
  }
  
  internal func display(_ gif: Gif) {
    let gifVC = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
    gifVC.gif = gif
    navigationController?.pushViewController(gifVC, animated: true)
  }

}
