//
//  DetailViewController.swift
//  PodcastFavorites
//
//  Created by Yuliia Engman on 12/17/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imagePodcast: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var podcast: UILabel!
    
    var onePodcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let somePodcast = onePodcast else {
            fatalError("could not get object from prepare for segue")
        }
        songName.text = somePodcast.trackName
        artistName.text = somePodcast.artistName
        podcast.text = somePodcast.collectionName
        imagePodcast.getImage(with: somePodcast.artworkUrl600) {[weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imagePodcast.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let podcastImage):
                DispatchQueue.main.async {
                    self?.imagePodcast.image = podcastImage
                }
            }
        }
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        
        guard let anyPodcast = onePodcast else {
            fatalError("error")
        }
        
        let podcastPost = Podcast(artistName: anyPodcast.artistName, trackName: anyPodcast.trackName, collectionName: anyPodcast.collectionName, artworkUrl100: anyPodcast.artworkUrl100, artworkUrl600: anyPodcast.artworkUrl600, trackId: anyPodcast.trackId, favoritedBy: "Yuliia")
        
//        let podcastPost = Podcast(artistName: onePodcast.artistName, trackName: onePodcast.trackName, collectionName: onePodcast.collectionName, artworkUrl100: onePodcast.artworkUrl100, artworkUrl600: onePodcast.artworkUrl600, trackId: onePodcast.trackId, favoritedBy: "Yuliia")
//        let podcastPost = Posdcast(trackId: onePodcast.trackId, favoritedBy: "Yuliia", collectionName: onePodcast.collectionName, artworkUrl600: onePodcast.artworkUrl600)
        
    PodcastSearchAPI.postFavoritePodcast(favoritePodcast: podcastPost) { [weak self, weak sender] result in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to Post Answer", message: "\(appError)")
                    sender?.isEnabled = true
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Favotite Podcast Added", message: "Enjoy your favorite podacsts.") { alert in
                        self?.dismiss(animated: true)
                    }
                }
            }
        }
}
}
