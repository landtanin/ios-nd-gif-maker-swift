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
      let videoURL = info[UIImagePickerControllerMediaURL] as! NSURL
      UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path!, nil, nil, nil)
      dismiss(animated: true, completion: nil)
    }
    
    
  }
  
  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
}
