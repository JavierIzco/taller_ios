//
//  File.swift
//  sdi_taller
//
//  Created by usuario on 25/11/2020.
//

import Foundation

struct WebService {
    
    static let numBeers = 20
    
    static let urlWebservice = "https://api.punkapi.com/v2/beers"
    
    
    static func getDatosBeers(page: Int, completion: @escaping (ArrayBeerJSON?) -> Void) {
        
        // Getting a URL from our components is as simple as
        // accessing the 'url' property.colorPrimario
        let url = URL(string:urlWebservice + "?page=\(page)&per_page=\(numBeers)")
        print (urlWebservice + "?page=\(page)&per_page=\(numBeers)")
        let session = URLSession.shared
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if json is Array<[String:Any]>{
                    var beers: ArrayBeerJSON = []
                    for dict in json as! Array<[String:Any]>{
                        let newBeer = Beer(dictionary: dict)
                        beers.append(newBeer)
                    }
                    completion(beers)
                }else{
                    print("Could not get API data.")
                }
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    
}

typealias DatoBeer = [String:Any]

typealias ArrayBeerJSON = Array<Beer>



struct Beer {
    
    var name: String
    var description: String
    var image: String
    
    init(dictionary: DatoBeer) {
        name = dictionary["name"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        image = dictionary["image_url"] as? String ?? ""
    }
    
}
