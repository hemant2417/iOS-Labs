//
//  ViewController.swift
//  Systemvc1
//
//  Created by Hemant Sardana on 29/08/25.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate{
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Sharebuttontapped(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        present(activityViewController, animated: true,completion: nil)
    }
    
    @IBAction func Safaributtontapped(_ sender: UIButton) {if let url = URL(string: "https://www.google.com") {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController,animated: true, completion: nil)
    }
    }
    @IBAction func camerabuttontapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        let alertController = UIAlertController(title: "Camera", message: nil, preferredStyle: .actionSheet)
        _ = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default,handler: {action in imagePicker.sourceType = .camera
                self.present(imagePicker,animated: true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker,animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)

    }

    @IBAction func emailButtonTapped(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail services are not available")
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["abcd@gmail.com"])
        mailComposer.setSubject("Hello")
        mailComposer.setMessageBody("Hello, how are you?", isHTML: false)
        present(mailComposer, animated: true)
        
        if let image = imageView.image, let jpegData = image.jpegData(compressionQuality: 0.9) {
            mailComposer.addAttachmentData(jpegData, mimeType: "image/jpeg", fileName: "image.jpeg")
            
        }
        present(mailComposer,animated: true,completion: nil)
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
        dismiss(animated: true, completion: nil)
    }
}



