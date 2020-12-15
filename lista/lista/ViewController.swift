//
//  ViewController.swift
//  lista
//
//  Created by javier on 15/12/2020.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datos?.ciudades.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! CiudadViewCell
        let ciudad = datos!.ciudades[indexPath.row]
        
        if let url = URL(string: ciudad.imagen) {
            cell.imagenImageView.load(url: url)
        }
        
        cell.nombreTextView.text = ciudad.nombre
        
        return cell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imagenImageView: UIImageView!
    
    @IBOutlet weak var nombreTextView: UILabel!
    
    @IBOutlet weak var edadTextView: UILabel!
    
    var datos: Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        WebService.conseguirDatos(nombre: "Luis"){ (datos) in
            DispatchQueue.main.async() {
                self.datos = datos!
                self.nombreTextView.text = datos?.nombre
                self.edadTextView.text = String(datos?.edad ?? 0)
                if let url = URL(string: datos?.imagen ?? "") {
                    self.imagenImageView.load(url: url)
                }
                self.collectionView.reloadData()
            }
        }
        
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

