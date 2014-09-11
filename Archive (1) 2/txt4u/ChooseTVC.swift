//
//  ChooseTVC.swift
//  txt4u
//
//  Created by Heidi Proske on 9/10/14.
//  Copyright (c) 2014 Heidi Proske. All rights reserved.
//

import UIKit

class ChooseTVC: FriendsTVC {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        var friendQuery = PFUser.query()
        friendQuery.findObjectsInBackgroundWithBlock { (users: [AnyObject]!, error: NSError!) -> Void in
            
            self.friends = users as [PFUser]
            self.tableView.reloadData()
            
        }

    }

    @IBAction func cancelChoice(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // choosing specific friends
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        var myOldFriends = ((self.navigationController?.presentingViewController as UINavigationController).viewControllers[0] as FriendsTVC.friends += [friends[indexPath.row]]
    
//
//        
//        var myFriends = friendsTVC.friends
//        
//        myFriends += [friends[indexPath.row]]
//
//
//        ((self.navigationController?.presentingViewController as UINavigationController).viewControllers[0] as FriendsTVC).friends += [friends[indexPath.row]]
//        
//
        
        
        var presentingNavC = self.navigationController?.presentingViewController as UINavigationController
        
        var friendsTVC = presentingNavC.viewControllers[0] as FriendsTVC
        
        friendsTVC.friends += [friends[indexPath.row]]
        
        // saving array of friends, to user in parse
        
        var user = PFUser.currentUser()
        user["friends"] = friendsTVC.friends
        user.saveInBackground()
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)

        
    }

}
