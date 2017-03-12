//
//  HomeViewController.swift
//  InstagramOnParse
//
//  Created by Lum Situ on 3/8/17.
//
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        getPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOutButton(_ sender: Any) {
        PFUser.logOutInBackground { (error:Error?) in
            if error != nil {
                print("Can not log out")
                print("Log out error: \(error?.localizedDescription)")
            } else {
                print("Log out!!")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userDidLogout"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeViewTableViewCell
        
        let post = posts[indexPath.row]
        cell.post = post
        
        return cell
    }
    
    public func getPosts() {
        // construct query
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                for post in posts {
                    print("Today is \(Date())")
                    self.posts.append(Post(object: post))
                    self.tableView.reloadData()
                }
                // do something with the array of object returned by the call
            } else {
                print(error?.localizedDescription)
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
