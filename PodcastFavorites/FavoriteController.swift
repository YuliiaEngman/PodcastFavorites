//
//  FavoriteController.swift
//  PodcastFavorites
//
//  Created by Yuliia Engman on 12/17/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    
    var favoritePodcast = [FavoritePodcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        configureRefreshControl()
        fetchFavorites()
    }
    
    func configureRefreshControl() {
      refreshControl = UIRefreshControl()
      tableView.refreshControl = refreshControl

      // programmable target-action using objective-c runtime api
      refreshControl.addTarget(self, action: #selector(fetchFavorites), for: .valueChanged)
    }
    @objc
    private func fetchFavorites() {
        PodcastSearchAPI.fetchFavorites {[weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed fetching answers", message: "\(appError)")
                }
            case .success(let podcasts):
                self?.favoritePodcast = podcasts.filter { $0.favoritedBy == "Yuliia" }
            }
        }
    }
    
}

extension FavoriteController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePodcast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritedCell", for: indexPath) as? FavoritedCell else {
            fatalError("could not dequeue FavoritedCell")
        }
        let favorite = favoritePodcast[indexPath.row]
        cell.configureFavoriteCell(for: favorite)
        
        return cell
        
    }
}
extension FavoriteController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}




