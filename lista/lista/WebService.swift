//
//  WebService.swift
//  lista
//
//  Created by javier on 15/12/2020.
//

import Foundation

struct WebService {
    
    static let urlWebservice = "https://puzzlys.com/api/perfil.php"
    
    
    static func conseguirDatos(nombre: String, completion: @escaping (Usuario?) -> Void) {
        
        // Getting a URL from our components is as simple as
        // accessing the 'url' property.colorPrimario
        let url = URL(string:urlWebservice + "?nombre=\(nombre)")
        let session = URLSession.shared
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if json is [String:Any]{
                    let nuevoUsuario: Usuario = Usuario(datos: json as! [String:Any])
                    completion(nuevoUsuario)
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

struct Ciudad{
    var nombre: String
    var imagen: String
    
    init(nombre: String, imagen: String){
        self.nombre = nombre
        self.imagen = imagen
    }
}


struct Usuario{
    var nombre: String
    var edad: Int
    var imagen: String
    var ciudades: [Ciudad]
    
    init (datos: [String:Any]){
        nombre = datos["nombre"] as? String ?? ""
        edad = datos["edad"] as? Int ?? 40
        imagen = datos["imagen"] as? String ?? ""
        self.ciudades = []
        for ciudad in datos["ciudades"] as? [[String:String]] ?? []{
            var ciudadDato: Ciudad = Ciudad(nombre: ciudad["nombre"] ?? "",imagen: ciudad["foto"] ?? "")
            self.ciudades.append(ciudadDato)
        }
        
    }
    
    
}
