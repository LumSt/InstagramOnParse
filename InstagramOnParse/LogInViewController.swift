//
//  LogInViewController.swift
//  InstagramOnParse
//
//  Created by Lum Situ on 3/5/17.
//
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignInButton(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameTextField!.text!, password: passwordTextField!.text!) { (user:PFUser?, error:Error?) in
            if user != nil {
                print("User've logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }

    @IBAction func onSignUpButton(_ sender: Any) {
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.signUpInBackground { (success:Bool, error:Error?) in
            if success {
                print("User registered successfully!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Sign up error:\(error?.localizedDescription)")
            }
        }
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
