//
//  PhotosViewController.swift
//  ningchongstagram
//
//  Created by Justin Aschenbener on 5/6/15.
//  Copyright (c) 2015 Justin Aschenbener. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var photosTableView: UITableView!
    
    var photos : [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup for tableView
        self.photosTableView.rowHeight = 320
        
        // Call to get info from instagram
        var clientId = "f57ddb10bb68402fa033c9275d62eb71"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            
            self.photos = responseDictionary["data"] as? [NSDictionary]
            
            // configure a feed of photos here
            self.photosTableView.reloadData()
            
            println("response: \(self.photos)")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return photos != nil ? photos!.count : 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.justinning.photoCell", forIndexPath: indexPath) as! PhotosTableViewCell
        
        var onePhotoDataDictionary: NSDictionary = (photos![indexPath.row] as NSDictionary)
//        var photoId : String? = onePhotoDataDictionary.objectForKey("id") as? String
        var lowResPhotoURL : String? = onePhotoDataDictionary.valueForKeyPath("images.low_resolution.url")! as? String
        
        cell.photosTableViewCellImageView.setImageWithURL(NSURL(string: lowResPhotoURL!))
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate methods
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! PhotosTableViewCell
        let photoData = photos![photosTableView.indexPathForCell(cell)!.row]
        
        let photoDetailController = segue.destinationViewController as! PhotoDetailsViewController
        photoDetailController.photo = photoData
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

class PhotosTableViewCell: UITableViewCell {
    @IBOutlet weak var photosTableViewCellImageView: UIImageView!

    
}