//
//  CollectionViewController.swift
//  StarWarsANewHIG
//
//  Created by Steve Graff on 5/25/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit




private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var results = [[String:AnyObject]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: NSURLSession
        let requestURL: NSURL = NSURL(string: "https://swapi.co/api/films/")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("All systems go! File downloaded successfully!")
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    if let results = json["results"] as? [[String:AnyObject]] {
                        for result in results {
                            if let title = result["title"] as? String {
                                if let episode = result["episode_id"] as? Int {
                                    self.results = results
                                    print("\(title) \(episode)")
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        self.collectionView?.reloadData()
                                    })
                                    
                                }
                            }
                        }
                    }
                } catch {
                    print("Error with JSON: \(error)")
                }
            }
        }
        
        task.resume()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "swapiCell")
        // Do any additional setup after loading the view.
    }
    
    // TODO: We need to do something with this 'results' object, use it to populate the CollectionView

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return results.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("swapiCell", forIndexPath: indexPath) as UICollectionViewCell
        
    
        // Configure the cell
        cell.contentView.backgroundColor = UIColor.cyanColor()
        
        let titleLabel: UILabel = UILabel()
        titleLabel.frame = CGRect( x: 10,y: 10, width: (cell.contentView.frame.width - 20), height: ((cell.contentView.frame.height - 30) / 4))
        titleLabel.backgroundColor = UIColor.darkGrayColor()
        titleLabel.textColor = UIColor.blueColor()
        titleLabel.text = "Foo!!"
        
        let episodeLabel: UILabel = UILabel()
        // episodeLabel.frame = CGRect(x: 10, y: (titleLabel.frame.height + 20), width: (cell.contentView.frame.width - 20), height: ((self.view.frame.height - 30) / 3) * 2)
        episodeLabel.frame = CGRect(x: 10, y: 50, width: titleLabel.frame.width, height: titleLabel.frame.height)
        episodeLabel.backgroundColor = UIColor.darkGrayColor()
        episodeLabel.textColor = UIColor.blueColor()
        episodeLabel.text = "Bar??"
        
        cell.addSubview(titleLabel)
        cell.addSubview(episodeLabel)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
