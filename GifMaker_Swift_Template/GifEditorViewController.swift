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
    subscribeToKeyboardNotifications()
    self.title = "Add a Caption"
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let gif = gif {
      gifImageView.image = gif.gifImage
    }
    
//    let defaultAttributes: [CFString:Any] = [kCTStrokeColorAttributeName: UIColor.black,
//                                      kCTStrokeWidthAttributeName: -4,
//                                      kCTForegroundColorAttributeName: UIColor.white,
//                                      kCTFontAttributeName: UIFont.fontNames(forFamilyName: "HelveticaNeue-CondensedBlack")
//      ]
//    
//    self.captionTextField.defaultTextAttributes = defaultAttributes as [String : Any]
//    self.captionTextField.textAlignment = .center
//    self.captionTextField.attributedPlaceholder = NSAttributedString.init(string: "Add Caption", attributes: defaultAttributes as [NSAttributedStringKey : Any])
    
    captionTextField.delegate = self
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
    self.view.addGestureRecognizer(tapGesture)
  }
  
  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }
  
}

extension GifEditorViewController: UITextFieldDelegate {
  
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow),
                                           name: .UIKeyboardWillShow,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide),
                                           name: .UIKeyboardWillHide,
                                           object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    if view.frame.origin.y >= 0 {
      view.frame.origin.y -= self.getKeyboardHeight(notification: notification)
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    if view.frame.origin.y < 0 {
      view.frame.origin.y += self.getKeyboardHeight(notification: notification)
    }
  }
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    guard let userInfo = notification.userInfo else {
      return 0.0
    }
    guard let keyboardFrameEnd = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
      return 0.0
    }
    return keyboardFrameEnd.cgRectValue.height

  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.placeholder = "";
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true;
  }
  
}
