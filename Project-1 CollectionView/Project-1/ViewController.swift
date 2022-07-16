//
//  ViewController.swift
//  Project-1
//
//  Created by Sagar Kadam on 16/06/22.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [Picture]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                var picture = Picture(pictureName: item, viewedCount: 0)
                pictures.append(picture)
            }
        }
//      pictures.sort()
        print(pictures)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellLabel", for: indexPath) as? NameCollectionCell else {
            fatalError("Unable to deque Person Cell")
        }
        let picture = pictures[indexPath.row]

        cell.cellLabel.text = picture.pictureName
    
        let defaults = UserDefaults.standard
        let viewedCount = defaults.integer(forKey: "\(picture.pictureName)")
        cell.viewedTimeLabel.text = "Viewed = \(viewedCount)"
        cell.layer.cornerRadius = 7
        return cell
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            var picture = pictures[indexPath.row]
            let defaults = UserDefaults.standard
            let viewedCount = defaults.integer(forKey: "\(picture.pictureName)")
            defaults.set(viewedCount+1, forKey: "\(picture.pictureName)")
            defaults.synchronize()
            vc.selectedImage = picture.pictureName
            vc.titleOfImage = "Picture \(indexPath.row + 1) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

