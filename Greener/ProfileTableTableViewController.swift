//
//  ProfileTableTableViewController.swift
//  Greener
//
//  Created by Studio on 21/02/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableTableViewController: UITableViewController {
    var user: String = ""
    
    var observer:Any?;
    var handle: AuthStateDidChangeListenerHandle?
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if (user != nil){
                self.user = (user?.email)!;
            }else{
                self.user = "";
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }
    
    @objc func reloadData(){
        print("========== reloading posts data ==========")
        Model.instance.getMyPosts(userId: Auth.auth().currentUser!.email!){(_data:[Post]?) in
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

         let post = data[indexPath.row];
                if (post.pic == "") {
                    let cell: PostTableViewCellNoPic
                    cell = tableView.dequeueReusableCell(withIdentifier: "PostCellNoPic", for: indexPath) as! PostTableViewCellNoPic
                    cell.userName.text = post.userId
                    cell.postContent.text = post.content
        //            let dafaultPicURL: String = "";
        //            cell.postPic.kf.setImage(with: URL(string: dafaultPicURL))
                    return cell
                }else {
                    let cell: PostTableViewCellWithPic
                    cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCellWithPic
                    cell.userName.text = post.userId
                    cell.postContent.text = post.content
                    cell.postPic.kf.setImage(with: URL(string: post.pic));
                    return cell
                }
    }
    
    var selected:Post?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "InfoPostSegue"){
            let vc:InfoViewController = segue.destination as! InfoViewController
            vc.post = selected
            if (vc.post?.userId == self.user)
            {
                vc.userId = self.user
                vc.isEditable = true
            }
        }
        else if (segue.identifier == "NewPost"){
            let vc:InfoViewController = segue.destination as! InfoViewController
            vc.isNew = true
            vc.userId = self.user
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = data[indexPath.row]
        performSegue(withIdentifier: "InfoPostSegue", sender: self)
    }
    
    
    
}
