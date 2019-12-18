//
//  FavoritedCell.swift
//  PodcastFavorites
//
//  Created by Yuliia Engman on 12/17/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class FavoritedCell: UITableViewCell {
    
    @IBOutlet weak var imagePodcast: UIImageView!
    @IBOutlet weak var podcastLabel: UILabel!
    @IBOutlet weak var myNameLabel: UILabel!
    

    func configureFavoriteCell(for favoritePodcast: Podcast) {
        podcastLabel.text = favoritePodcast.collectionName
        myNameLabel.text = favoritePodcast.favoritedBy
    
        
        // use a capture list e.g. [weak self] or [unowned self] to break strong or (retain) reference cycle
        imagePodcast.getImage(with: favoritePodcast.artworkUrl600) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imagePodcast.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                // what thread are we on? global() background
                DispatchQueue.main.async {
                    self?.imagePodcast.image = image
                }
            }
        }
    }
}
