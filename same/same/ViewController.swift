//
//  ViewController.swift
//  same
//
//  Created by VC on 11/12/16.
//  Copyright © 2016 eyu. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        print("Successfully logged in with facebook...")
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        //frame's are obselete, please use constraints instead because its 2016 after all
        loginButton.readPermissions = ["user_friends"]
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
        
        
    }
    
    /*  um dumb button*/
    @IBAction func click(_ sender: Any) {
//        let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
        let params = ["fields": "id"]
        let request = FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: params)
        request!.start(completionHandler:  { (connection, result, error) in
            if let _ = error {
                let _ = error!.localizedDescription
            }
            
            let resultdict = result as! NSDictionary
            print("Result Dict: \(resultdict)")
            let data : NSArray = resultdict.object(forKey: "data") as! NSArray
            
            for i in 0 ..< data.count
            {
                let valueDict : NSDictionary = data[i] as! NSDictionary
                let id = valueDict.object(forKey:"id") as! String
                print("the id value is \(id)")
            }
            
            let friends = resultdict.object(forKey: "data") as! NSArray
            print("Found \(friends.count) friends")

        })
    }
    
    @IBAction func sendStuff(_ sender: Any) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "")! as URL) // removed graph token
        request.httpMethod = "POST"
        let postString = "id=13&name=Jack"
        var data = NSData.init(contentsOfFile: "{\"recipient\":{\"id\":\"100001058174866\"},\"message\":{\"text\":\"helloworld!\"}}")
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        /*request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")*/
        request.httpBody = data as Data?
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
    
    
}

