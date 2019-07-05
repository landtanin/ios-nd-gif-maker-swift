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
  
  override func viewDidLoad() {
    captionTextField.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    subscribeToKeyboardNotifications()
    if let gif = gif {
      gifImageView.image = gif.gifImage
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }
  
}

extension GifEditorViewController: UITextFieldDelegate {
  
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWillShow(sender: AnyObject) {
    if self.view.frame.origin.y >= 0 {
      var rect = self.view.frame
//      rect.origin.y -=
    }
  }
  
  @objc func keyboardWillHide(sender: AnyObject) {
    
  }
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
//    let userInfo = notification.userInfo
    
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.placeholder = "";
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true;
  }
  
}
