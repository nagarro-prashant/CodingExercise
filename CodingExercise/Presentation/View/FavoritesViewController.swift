//
//  FavoritesViewController.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    private var viewModel: FavoritesViewModel!
    
    func assignDependencies(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        self.title = "Favorites"

        viewModel.posts
            .bind(to: tableView.rx.items(cellIdentifier: "FavoriteCell")) { row, post, cell in
                cell.textLabel?.text = post.title
            }
            .disposed(by: disposeBag)

        tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.viewModel.deleteFavourite(indexPath.row)
                // Post notification to update PostsViewController
                NotificationCenter.default.post(name: Notification.Name("FavoritePostDeleted"), object: nil)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.fetchFavorites()
    }
    
    deinit {
        print("FavoritesViewController deinitialized")
    }
}
