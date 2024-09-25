//
//  PostsViewController.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import UIKit
import RxSwift
import RxCocoa

class PostsViewController: UITableViewController {

    private var viewModel: PostsViewModel!
    private var router: PostsViewRouter!
    
    let bag = DisposeBag()
    
    func assignDependencies(viewModel: PostsViewModel, router: PostsViewRouter) {
        self.viewModel = viewModel
        self.router = router
    }
    
    override func viewDidLoad() {
        
        self.title = "Posts"
        
        setupTableview()
        setupBindings()
        
        // Add logout button
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func logout() {
        self.viewModel.logout()
        self.router.showLoginScreen()
    }
    
    private func setupTableview() {
        tableView.delegate = nil
        tableView.dataSource = nil
    }
    
    private func setupBindings() {
        viewModel.posts
            .bind(to: tableView.rx.items(cellIdentifier: "PostCell")) { row, post, cell in
                cell.textLabel?.text = post.title
                cell.accessoryType = post.isFavorite ? .checkmark : .none
            }
            .disposed(by: bag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.viewModel.toggleFavourite(indexPath)
            })
            .disposed(by: self.bag)
        // Listen for notification to update posts
         NotificationCenter.default.addObserver(self, selector: #selector(updatePosts), name: Notification.Name("FavoritePostDeleted"), object: nil)
    }
    
    @objc func updatePosts() {
        // Re-fetch posts or update the UI accordingly
        viewModel.fetchLocal()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("💀 PostsViewController deinitialized")
    }

}


