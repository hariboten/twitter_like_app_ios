//
//  PostTweetViewController.swift
//  HelloWorld
//
//  Created by PC220206 on 2022/09/01.
//

import Foundation
import UIKit

class PostTweetViewController: UIViewController, UITextViewDelegate {
    var tweetStorage: TweetStorage?
    @IBOutlet weak var postTweetButton: UIButton!
    @IBOutlet weak var tweetContentText: UITextView!
    
    @IBAction func Tweet(_ sender: Any) {
        let tweet = HelloWorld.Tweet(content: tweetContentText.text ?? "")
        tweetStorage?.postTweet(tweet: tweet)
        dismiss(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tweetContentText.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = tweetContentText.text else {
            return
        }
        let is_tweetable = (text != "") && (text.count <= 140)
        postTweetButton.isEnabled = is_tweetable
        
        let attributedText = NSMutableAttributedString(string: text)
        
        if attributedText.length <= 140 {
            return
        }
        attributedText.addAttributes([.backgroundColor: UIColor.systemPink], range: NSRange(location: 140, length: attributedText.length - 140))

        tweetContentText.attributedText = attributedText
    }
}
