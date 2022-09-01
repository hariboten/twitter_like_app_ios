//
//  TimeLineViewController.swift
//  HelloWorld
//
//  Created by PC220206 on 2022/09/01.
//

import Foundation
import UIKit

protocol TweetStorage {
    func postTweet(tweet: Tweet)
}

class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetStorage{
    @IBOutlet weak var timelineTable: UITableView!
    var tweets: [Tweet]
    
    required init?(coder: NSCoder) {
        self.tweets = []
        super.init(coder: coder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TimelineTweetCell
        
        let tweet = tweets[tweets.count - indexPath.row - 1]
        cell.content.text = "\(tweet.content)"
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0...10 {
            let tweet = Tweet(content: "tweet \(i)")
            tweets.append(tweet)
        }

        
        timelineTable.delegate = self
        timelineTable.dataSource = self
        
        timelineTable.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PostTweetViewController {
            viewController.tweetStorage = self
        }
    }
    
    func postTweet(tweet: Tweet) {
        tweets.append(tweet)
        timelineTable.reloadData()
    }
}

class TimelineTweetCell: UITableViewCell {
    @IBOutlet weak var content: UILabel!
}
