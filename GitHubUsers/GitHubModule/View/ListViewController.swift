//
//  ViewController.swift
//  GitHubUsers
//
//  Created by Vikram on 15/02/22.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var gitTableView: UITableView!
    var gitViewModel = GitHubViewModel()
    var gitUserList = [GitHubUsers]()
    var isLoadingList = false
    var lastUserId = 0
    var networkReachability = NetworkReachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        if networkReachability.isNetworkAvailable() {
            makeServiceCall(lastUserId: lastUserId)
        } else {
            showNetworkAlert(viewController: self)
        }
        
        gitViewModel.reloadTableView =  { [weak self] in
            DispatchQueue.main.async { [self] in
                self?.gitTableView.reloadData()
                self?.isLoadingList = false
            }
        }
    }
    
    func initViews() {
        let textFieldCell = UINib(nibName: Constants.CELL_IDENTIFIER,
                                      bundle: nil)
        self.gitTableView.register(textFieldCell,
                                    forCellReuseIdentifier: Constants.CELL_IDENTIFIER)
        self.gitTableView.delegate = self
        self.gitTableView.dataSource = self
        self.gitTableView.allowsSelection = true
        self.gitTableView.separatorColor = UIColor.black
        self.gitTableView.alwaysBounceVertical = false
    }
    
    func makeServiceCall(lastUserId: Int) {
        gitViewModel.fetchUserList(from: lastUserId, perPage: 100)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gitViewModel.gitUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER) as? GitHubCustomCell {
            cell.tag = indexPath.row
            cell.userIdLabel.text = gitViewModel.gitUsers[indexPath.row].loginName
            if cell.tag == indexPath.row {
                cell.userImageView.setCustomImage(gitViewModel.gitUsers[indexPath.row].avatarUrl)
            }
            let attributedString = NSMutableAttributedString.init(string: gitViewModel.gitUsers[indexPath.row].url)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                            NSRange.init(location: 0, length: attributedString.length));
            cell.userLink.attributedText = attributedString
            
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: Constants.MAIN_STORYBOARD, bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.DETAIL_CONTROLLER_IDENTIFIER) as? DetailViewController
        vc?.api_url = gitViewModel.gitUsers[indexPath.row].url
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > (scrollView.contentSize.height)) && !isLoadingList){
            self.isLoadingList = true
            if let lastElement = self.gitViewModel.gitUsers.last, self.lastUserId != lastElement.id {
                self.lastUserId = lastElement.id
                if networkReachability.isNetworkAvailable() {
                    makeServiceCall(lastUserId: lastUserId)
                } else {
                    showNetworkAlert(viewController: self)
                }
            }
        }
    }
}

