//
//  PodcastCell.swift
//  PodcastFavorites
//
//  Created by Yuliia Engman on 12/17/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var podcastNameLabel: UILabel!
    @IBOutlet weak var podcastImage: UIImageView!
    
    

   func configureCell(for podcast: Podcast) {
    artistNameLabel.text = podcast.artistName
    songNameLabel.text = podcast.trackName
    podcastNameLabel.text = podcast.collectionName
        
        // set image for recipe
        
        // use a capture list e.g. [weak self] or [unowned self] to break strong or (retain) reference cycle
    podcastImage.getImage(with: podcast.artworkUrl100 ?? "") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.podcastImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                // what thread are we on? global() background
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                }
            }
        }
    }
}
