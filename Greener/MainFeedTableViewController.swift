//
//  MainFeedTableViewController.swift
//  Greener
//
//  Created by Studio on 01/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class MainFeedTableViewController: UITableViewController {
    
    @IBOutlet weak var addNewPost: UIBarButtonItem!
    @IBOutlet weak var LogOut: UIBarButtonItem!
    
    @IBAction func LogOut(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    var observer:Any?;
    
    var data = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        ModelEvents.PostDataEvent.observe {
            self.refreshControl?.beginRefreshing()
            self.reloadData();
        }
        self.refreshControl?.beginRefreshing()
        self.reloadData();
    // MARK: - Table view data source
    }
    @objc func reloadData(){
        print("========== reloading posts data ==========")
        Model.instance.getAllPosts{(_data:[Post]?) in
            if (_data != nil) {
                           self.data = _data!;
                           self.tableView.reloadData();
                       }
                       self.refreshControl?.endRefreshing()
                   };
       }
    override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return data.count
       }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell

        let post = data[indexPath.row]
        cell.userName.text = post.userId
        cell.postContent.text = post.content
//        cell.postPic.image = UIImage(named: "scrnli")
        return cell
    }

    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  if let cellBtn = sender as? UIButton {
        //    let cell = cellBtn.superview?.superclass as? PostTableViewCell
          //  let i = self.index(ofAccessibilityElement: cell)
            //if (segue.identifier == "EditPostSegue"){
              //  let vc:EditPostViewController = segue.destination as! //EditPostViewController
   //             vc.post = data[i]
     //       }
       // }
    //}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "InfoPostSegue"){
            let vc:InfoViewController = segue.destination as! InfoViewController
            vc.post = selected
        }
    }
    
    var selected:Post?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = data[indexPath.row]
        performSegue(withIdentifier: "InfoPostSegue", sender: self)
    }
}
