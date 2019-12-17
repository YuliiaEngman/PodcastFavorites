//
//  PodcastModel.swift
//  PodcastFavorites
//
//  Created by Yuliia Engman on 12/17/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import Foundation

struct PosdcastSearch: Decodable {
    let results: [Podcast]
}

struct Podcast: Decodable {
    let artistName: String
    let trackName: String
    let collectionName: String // we doing search on it
    let genres: [String]
    let artworkUrl100: String // URL image more main VC
    let artworkUrl600: String // URL image
    let trackId: Int
}


//"genres": [
//              "Society & Culture",
//              "Podcasts",
//              "History"
//          ]
