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
    
    let defaultAttributes: [String:Any] = [NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
                             NSAttributedStringKey.strokeWidth.rawValue: -4,
                             NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
                             NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)!
    ]

    let defaultPlaceholderAttributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.strokeColor: UIColor.black,
                                           NSAttributedStringKey.strokeWidth: -4,
                                           NSAttributedStringKey.foregroundColor: UIColor.white,
                                           NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)!
      ]

    
    self.captionTextField.defaultTextAttributes = defaultAttributes
    self.captionTextField.textAlignment = .center
    self.captionTextField.attributedPlaceholder = NSAttributedString.init(string: "Add Caption", attributes: defaultPlaceholderAttributes)
    
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
  
  @IBAction func presentPreview(_ sender: Any) {
    
    let previewVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
    self.gif?.caption = self.captionTextField.text
    
    guard let gifVideoUrl = gif?.videoURL else {
      return
    }
    
    let regift = Regift(sourceFileURL: gifVideoUrl, destinationFileURL: nil, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount)
    guard let gifURL = regift.createGif(captionTextField.text, font: captionTextField.font) else {
      return
    }
    
    let newGif = Gif(url: gifURL, videoURL: gifVideoUrl, caption: captionTextField.text)
    previewVC.gif = newGif
    
    self.navigationController?.pushViewController(previewVC, animated: true)
    
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
