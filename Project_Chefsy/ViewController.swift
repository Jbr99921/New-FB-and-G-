//
//  ViewController.swift
//  Project_Chefsy
//
//  Created by XongoLab on 12/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

import GoogleSignIn
//Jignesh //
var  flag:Bool = false

class ViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {
  
    
    
   

    @IBOutlet weak var ScrlView: UIScrollView!
    @IBOutlet weak var BtnGoogle: UIControl!
    @IBOutlet weak var BtnFacebook: UIControl!
    @IBOutlet weak var BtnContinue: UIButton!
    @IBOutlet weak var TxtUsername: UITextField!
    @IBOutlet weak var TxtEmail: UITextField!
    @IBOutlet weak var TxtContactNumber: UITextField!
    @IBOutlet weak var TxtPassword: UITextField!
    @IBOutlet weak var BtnShowPassword: UIButton!
    
    
    var dictionaries = [String:Any]()
    var iconClick = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // FOR G+
         GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        
        // For FB....
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email"]
        
        ScrlView.contentSize = CGSize(width:self.view.frame.size.width, height:667)
        BtnFacebook.layer.cornerRadius = 20
        BtnFacebook.layer.borderWidth = 1
        BtnFacebook.layer.borderColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1).cgColor
        
        BtnGoogle.layer.cornerRadius = 20
        BtnGoogle.layer.borderWidth = 1
        BtnGoogle.layer.borderColor = UIColor.red.cgColor
    
        self.BtnContinue.layer.cornerRadius = 25
        self.BtnContinue.layer.borderWidth = 1
        self.BtnContinue.layer.borderColor = UIColor.red.cgColor
        BtnContinue.backgroundColor = .clear
       
         textfieldlayout()
    }
    func textfieldlayout(){
        TxtUsername.leftViewMode = UITextFieldViewMode.always
        //let paddding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "user")
        imageView.image = image
        TxtUsername.leftView = imageView
        
        
        TxtEmail.leftViewMode = UITextFieldViewMode.always
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image1 = UIImage(named: "email")
        imageView1.image = image1
        TxtEmail.leftView = imageView1
        
        
        TxtPassword.leftViewMode = UITextFieldViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image2 = UIImage(named: "password")
        imageView2.image = image2
        TxtPassword.leftView = imageView2
        
        
        TxtContactNumber.leftViewMode = UITextFieldViewMode.always
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image3 = UIImage(named: "number")
        imageView3.image = image3
        TxtContactNumber.leftView = imageView3
    }
    
    
    
    @IBAction func BtnFacebook(_ sender: UIControl) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email"], from: self){ (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error != nil){
                    
                    print(error?.localizedDescription)
                }else{
                    print(result as! NSDictionary)
                    
                    self.dictionaries = result as! [String : Any]
                    
                    print(self.dictionaries)
                    self.TxtUsername.text = self.dictionaries["name"] as! String?
                    self.TxtEmail.text = self.dictionaries["email"] as! String?
                    
                }
            })
        }
    }
    
    // MARK: - For Google+ Integration......
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
            print("******************************************************************************")
            print(user.profile.email!)
            print(user.profile.name!)
            print(user.profile.givenName!)
            print(user.profile.familyName!)
            print(user.userID!)
            print("******************************************************************************")
            print(fullName!)
            TxtUsername.text = fullName
            TxtEmail.text = email
            
            //            print(user as! NSObject)
            //            self.TxtUsername.text = user["name"] as! String?
            //            self.TxtEmail.text = user["email"] as! String?
            //            print(self.dictionaries)
            //         self.TxtUsername.text =
            //            self.TxtEmail.text = self.dictionaries[email!] as! String?
            //
            
        }
        
    }
    
    
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func BtnGoogle(_ sender: UIControl) {
       print("google button pressed")
       
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    @IBAction func BtnShowPass(_ sender: UIButton) {
        if(iconClick == true) {
            TxtPassword.isSecureTextEntry = false
        } else {
            TxtPassword.isSecureTextEntry = true
        }
        
        iconClick = !iconClick
    }

    @IBAction func BtnCOntinue(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        GIDSignIn.sharedInstance().signOut()
    }
    
}

