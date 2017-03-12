//
//  Post.swift
//  InstagramOnParse
//
//  Created by Lum Situ on 3/11/17.
//
//

import UIKit
import Parse

class Post: NSObject {
    
    var image: PFFile?
    var user: PFUser?
    var caption: String?
    var dateString: String?
    
    init(object: PFObject) {
        image = object["media"] as? PFFile
        user = object["author"] as? PFUser
        caption = object["caption"] as? String
        if let postDate = object.createdAt {
            
        }
    }

    //Method to add a user post to Parse (upload image file)
    // - parameter image: Image that the user wants upload to Parse
    // - parameter caption: Caption text input by the user
    // - parameter completion: Block to be executed after save operation is complete
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevent fields to the object
        post["media"] = getPFFileFromImage(image: image)
        post["author"] = PFUser.current()
        post["caption"] = caption
        
        
        // Save object
        post.saveInBackground(block: completion)
    }
    
    // Method to convert UIImage to PFFile
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)!
            }
        }
        
        return nil
    }
}
