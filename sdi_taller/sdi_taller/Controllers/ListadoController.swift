//
//  ListadoController.swift
//  sdi_taller
//
//  Created by usuario on 24/11/2020.
//

import Foundation
import UIKit

class ListadoController: UIViewController {
    
    var isFetchingData = false
    var hasNoMoreData = false
    var previousScrollOffset: CGFloat = 0

    @IBOutlet weak var productosCollection: UICollectionView!
    
    var beers: [Beer] = []
    
    var page = 1
    
    var countries: [String] = ["London", "Paris", "Madrid", "Logroño", "Barcelona"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productosCollection.delegate = self
        productosCollection.dataSource = self
        
        WebService.getDatosBeers(page: page){ (datos) in
            self.beers = datos ?? []
            if (self.beers.count==0){
                self.hasNoMoreData=true;
            }
            DispatchQueue.main.async() {
                self.productosCollection.reloadData()
                self.isFetchingData = false
            }
        }
        
    }

    @IBAction func atrasButton(_ sender: Any) {
        
        self.dismiss(animated: false)
        
        
    }
    
}

extension ListadoController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PRODUCTO", for: indexPath) as! productoCell
        let beer = beers[indexPath.row]
        
        if let url = URL(string: beer.image) {
            cell.imagen.load(url: url)
        }
        
        cell.nombreLabel.text = beer.name
        
        cell.descriptionTextView.text = beer.description
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let beer = beers[indexPath.row]
        print("Has pulsado: \(beer.name)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        self.previousScrollOffset = scrollView.contentOffset.y
        
        if (ScrolledToBottomWithBuffer(contentOffset: scrollView.contentOffset, CGSize: scrollView.contentSize, contentInset: scrollView.contentInset, bounds: scrollView.bounds) && !self.isFetchingData && !self.hasNoMoreData) {
            self.isFetchingData = true
            self.page += 1
            WebService.getDatosBeers(page: self.page){ (datos) in
                self.beers += datos ?? []
                if (datos?.count ?? 0 < WebService.numBeers){
                    self.hasNoMoreData=true;
                }
                DispatchQueue.main.async {
                    self.productosCollection.reloadData()
                    self.isFetchingData = false
                }
            }
        }
        
    }
    
    func ScrolledToBottomWithBuffer(contentOffset: CGPoint, CGSize contentSize: CGSize, contentInset: UIEdgeInsets , bounds: CGRect ) -> Bool {
        var buffer = bounds.height - contentInset.top - contentInset.bottom;
        var maxVisibleY = (contentOffset.y + bounds.size.height);
        var actualMaxY = (contentSize.height + contentInset.bottom);
        return ((maxVisibleY + buffer) >= actualMaxY);
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
