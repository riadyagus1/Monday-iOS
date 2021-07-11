//
//  ProfileViewController.swift
//  Monday
//
//  Created by Agus Riady on 11/07/21.
//

import UIKit

// MARK: Extentsion Untuk Photo Jadi Bulat
extension UIImageView {
    func makePhotoRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
// Extentsion Untuk Photo Jadi Bulat (End)

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageViewPic: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    
    var fotoProfilNow: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewPic.makePhotoRounded()
        
        //MARK: Ambil data dari Login Screen
        let userDefault = UserDefaults.standard
            
        lblEmail.text = userDefault.string(forKey: "email")
        lblEmail.isUserInteractionEnabled = false
        
        //MARK: Ganti Foto Profil
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        // Ganti Foto Profil (End)
    }
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func photoProfile(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        /*If you want work actionsheet on ipad
        then you have to use popoverPresentationController to present the actionsheet,
        otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }

        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallery()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker .dismiss(animated: true, completion: nil)
        let fotoProfil = info[.editedImage] as! UIImage
        imageViewPic.image = fotoProfil
        self.fotoProfilNow = fotoProfil
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        // Create new Alert
        let dialogMessage = UIAlertController(title: "Log Out Berhasil", message: "\n Terima kasih sudah menggunakan aplikasi kami", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Log Out Success")
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FirstScreen") as! ViewController
            newViewController.modalPresentationStyle = .fullScreen
            self.show(newViewController, sender: self)
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    

}
