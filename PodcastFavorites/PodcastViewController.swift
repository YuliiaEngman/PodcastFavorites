//
//  ViewController.swift
//  PodcastFavorites
//
//  Created by Yuliia Engman on 12/17/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var podcasts = [Podcast]() {
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
        searchBar.delegate = self
        searchPodcast(searchQuery: "")
        navigationItem.title = "Podcast Search"
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not downcast to DetailViewController")
        }
        let singlePodcast = podcasts[indexPath.row]
        detailVC.onePodcast = singlePodcast
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
//               fatalError("could not segue to second VC")
//           }
//           let card = cards[indexPath.row]
//           detailVC.card = card
//       }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      if segue.identifier == "showAnswerQuestion" {
//        guard let navController = segue.destination as? UINavigationController,
//          let answerQuestionController = navController.viewControllers.first as? AnswerQuestionController else {
//          fatalError("could not downcast to AnswerQuestionController")
//        }
//        answerQuestionController.question = question
//      } else if segue.identifier == "showAnswers" {
//        // pass the question over to the AnswersViewController
//        guard let answersViewController = segue.destination as? AnswersViewController else {
//          fatalError("could not downcast to AnswersViewController")
//        }
//        answersViewController.question = question
//      }
//    }
    
    func searchPodcast(searchQuery: String) {
        PodcastSearchAPI.fetchPodcast(for: searchQuery, completion: {[weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            // TODO: alert controller
            case .success(let podcasts):
                self?.podcasts = podcasts
            }
        })
    }
}


extension PodcastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
            fatalError("could not dequeue PodcastCell")
        }
        let podcast = podcasts[indexPath.row]
        cell.configureCell(for: podcast)
        
        return cell
    }
}

extension PodcastViewController: UISearchBarDelegate {
    //activates search button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        //WE WOULD USE THIS FUNCTION _ SEAARCG DONE WHEN USER CLICKS SEARCH IF WE WOULD BE LIMITED ON VCALLS GTO API
        //        // we will use guard let to unwrap the searchbar property because its an optional
        //        guard let searchText = searchBar.text else {
        //            print("missing search text")
        //            return
        //        }
        //        searchPodcast(searchQuary: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        //WE WOULD USE THIS FUNCTION _ SEAARCG DONE WHEN USER ENTERS ANY LETTER IF WE ARE NOT LIMITED ON CALLS TO API
        
        searchPodcast(searchQuery: searchQuery)
    }
}

extension PodcastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


// FOR SEARCH BAR WE NEED:
//1. searchBar.delegate = self -inside viewDidLoad
// 2. search function
// 3. extension (method) for UISearchBarDelegate
