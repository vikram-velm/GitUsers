//
//  DetailViewController.swift
//  GitHubUsers
//
//  Created by Vikram on 17/02/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBlog: UILabel!
    @IBOutlet weak var userFollowers: UILabel!
    @IBOutlet weak var userFollowing: UILabel!
    
    var api_url = ""
    var gitViewModel = GitHubViewModel()
    var networkReachability = NetworkReachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.black.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.clipsToBounds = true
        
        if networkReachability.isNetworkAvailable() {
            gitViewModel.fetchUserDetail(url: api_url)
        } else {
            showNetworkAlert(viewController: self)
        }
        
        gitViewModel.populateData = { [weak self] in
            DispatchQueue.main.async { [self] in
                self?.userName.text = self?.gitViewModel.userDetail?.name
                let attributedString = NSMutableAttributedString.init(string: self?.gitViewModel.userDetail?.blog ?? "")
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                                NSRange.init(location: 0, length: attributedString.length));
                self?.userBlog.attributedText = attributedString
                let tap = UITapGestureRecognizer(target: self, action: #selector(self?.openLink(_ :)))
                self?.userBlog.isUserInteractionEnabled = true
                self?.userBlog.addGestureRecognizer(tap)
                self?.userFollowers.text = String((self?.gitViewModel.userDetail?.followers) ?? 0)
                self?.userFollowing.text = String((self?.gitViewModel.userDetail?.following) ?? 0)
                self?.userImageView.setCustomImage(self?.gitViewModel.userDetail?.avatarUrl)
            }
        }
    }
    
    @objc func openLink(_ tapGesture: UITapGestureRecognizer) {
        guard let url = URL(string: self.gitViewModel.userDetail?.blog ?? "") else { return }
        UIApplication.shared.open(url)
    }
}
