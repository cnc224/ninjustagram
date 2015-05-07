//
//  PhotoDetailsViewController.swift
//  ningchongstagram
//
//  Created by Justin Aschenbener on 5/6/15.
//  Copyright (c) 2015 Justin Aschenbener. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    var photo : NSDictionary?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photoUrl = photo?.valueForKeyPath("images.low_resolution.url") as? String {
            photoImageView.setImageWithURL(NSURL(string: photoUrl))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
