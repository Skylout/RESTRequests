//
//  Networking.swift
//  RESTRequests
//
//  Created by Леонид on 18.06.2021.
//

import Foundation

//специально вынесены как глобальные переменны, но любые ссылки в запросы лучше вставлять как аргумент функции. Тут так сделано чисто в образовательных целях
let getURL = "https://jsonplaceholder.typicode.com/posts/1"
let postURL = ""

class URLNetworking {
    
    func getRequest (completion: @escaping (_ result: String)->()){
        guard let url = URL(string: getURL) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            if response.statusCode != 200 {
                DispatchQueue.main.async {
                    completion("Статус запроса:\(response.statusCode). Что значит что полученных данных не поступило :(")
                }
            } else {
                do {
                    let decoder = JSONDecoder()
                    let jsonString = try decoder.decode(JsonGetModel.self, from: data)
                    DispatchQueue.main.async {
                        completion("Полученный JSON. \n userID:\(jsonString.userId)\n id:\(jsonString.id)\n title:\(jsonString.title)\n body:\(jsonString.body)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion("Произошла ошибка при обработки JSON:\(error)")
                    }
                }
            }
            
        }.resume()
    }
    
    static func postRequest (completion: @escaping (_ result: String)->()){
        
    }
}

//Лучше вынести класс ниже в отдельный файл, но в образовательных целях они остаются в одном, так как обеспечивают идентичный функционал
class AlamofireNetworking {
    static func getRequest (completion: @escaping (_ result: String)->()){
        
    }
    
    static func postRequest (completion: @escaping (_ result: String)->()){
        
    }
}
