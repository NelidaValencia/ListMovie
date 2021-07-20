//
//  CarouselViewController.swift
//  choiceTecnicoMobileDev
//
//  Created by Nelida Valencia on 19/07/21.
//

import UIKit
import AVFoundation

class CarouselViewController: UIViewController {
    @IBOutlet weak var collection_Poster: UICollectionView!
    @IBOutlet weak var collection_Thumbs: UICollectionView!
    let bussines = BusinessController()
    var type = ""
    var token = ""
    var arrayMovie: [MovieR] = []
    var detailMovie: [DetailMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collection_Thumbs.isHidden = true
//        collection_Poster.isHidden = true
        self.getMovies()
        collection_Poster.dataSource = self
        collection_Thumbs.dataSource = self
    }
    
    


    func getMovies() {
        DispatchQueue.global(qos: .background).async {
            self.bussines.executeMovies(type: self.type, token: self.token) { (data, detail, result, message, status) in
                if result {
                    DispatchQueue.main.async {
                        self.arrayMovie = data ?? []
                        self.detailMovie = detail ?? []
                        self.collection_Thumbs.isHidden = false
                        self.collection_Poster.isHidden = false
                        self.collection_Thumbs.reloadData()
                        self.collection_Poster.reloadData()

                        print("ARRAY MOVIE", self.arrayMovie)
                        print("DETAIL MOVIE", self.detailMovie)
                    }
                }
            }
        }
        
    }

    
}


extension CarouselViewController : UICollectionViewDelegate{}

extension CarouselViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collection_Poster {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPoster", for: indexPath)
            
            return cell
        }
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellThumbs", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
            let videoURL = URL(string: "https://d11gqohmu80ljn.cloudfront.net/128/media-20210712191955-cbdi-0.m3u8/master.m3u8")
            let player = AVPlayer(url: videoURL!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            player.play()
        
        
    }
}
