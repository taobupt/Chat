//
//  ChatViewController.swift
//  Chat
//
//  Created by Tao Wang on 1/29/17.
//  Copyright © 2017 Tao Wang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    
    var message = [PFObject]()
    var userNameinfo: String?
    @IBOutlet weak var SendButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var MessageInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self

        
        self.navigationItem.title="Chat"
        
        
        
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        SendButton.addTarget(self, action: #selector(self.sendMessage), for: .touchDown)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sendMessage(){
        var message = NSString(string: MessageInput.text!) as! String
        let newMessage = PFObject(className: "Message")
        newMessage["text"] = message
        let activeUser: String = (PFUser.current()?.username)!
        self.userNameinfo = activeUser
        newMessage["userId"] = activeUser
        newMessage.saveInBackground(block: {(returnedResult, returnedError) -> Void in
            if returnedError == nil
            {
                print("success")
                print(message)
                //self.rformSegue(withIdentifier: "createNewUserAndGoToDashboard", sender: self)
            }else{
                let alertController = UIAlertController(title: "Error", message:
                    "store message failure", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
                print(returnedError)
            }
        })
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        
        cell.information.text = message[indexPath.row].object(forKey: "text") as! String
        return cell
    }
    
    func onTimer(){
        
        var query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        if let userNameinfo = self.userNameinfo {
            print(userNameinfo)
            query.whereKey("userId", equalTo: userNameinfo)
            query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    
                    self.message = objects
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print(error)
            }
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
