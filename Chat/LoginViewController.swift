//
//  LoginViewController.swift
//  Chat
//
//  Created by Tao Wang on 1/29/17.
//  Copyright © 2017 Tao Wang. All rights reserved.
//

import UIKit
import Parse


extension String {
    public func index(of char: Character) -> Int? {
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        return nil
    }
}


class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var signup: UIButton!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var PasswordInput: UITextField!
    @IBOutlet weak var Email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login.addTarget(self,action: #selector(LoginViewController.loginButton), for: .touchDown)
        signup.addTarget(self, action: #selector(self.signupButton), for: .touchDown)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signupButton(){
        var user = PFUser()
        user.password = NSString(string: PasswordInput.text!) as! String
        user.email = NSString(string: Email.text!) as! String
        user.username = getSubstring(emai: user.email!)
//        print(user.password)
//        print(user.email)
//        print(user.username)
//        print(user.email)
        user.signUpInBackground { (returnedResult, returnedError) -> Void in
            if returnedError == nil
            {
                print("success")
                //self.performSegue(withIdentifier: "createNewUserAndGoToDashboard", sender: self)
            }
            else
            {
                let alertController = UIAlertController(title: "Error", message:
                    "User name exist", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
                print(returnedError)
            }
        }

    }
    func loginButton(){
        
            let password = NSString(string: PasswordInput.text!) as! String
            var email = NSString(string: Email.text!) as! String
            email = getSubstring(emai: email)
            print(email)
            PFUser.logInWithUsername(inBackground: email, password: password, block: { (user, error) -> Void in
                if user == nil {
                    let alertController = UIAlertController(title: "Error", message:
                        "Account does not exist", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }else {
                    print(PFUser.current()?.email)
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
                
            })

    }
    
    func getSubstring(emai: String) -> String{
        var email=emai
        let needle: Character = "@"
        if let idx = email.characters.index(of: needle) {
            let pos = email.characters.distance(from: email.startIndex, to: idx)
            let range = email.index(email.startIndex,offsetBy: pos)..<email.endIndex
            email.removeSubrange(range)
        }
        return email
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
