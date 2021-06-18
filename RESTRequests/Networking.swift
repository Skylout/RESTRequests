//
//  Networking.swift
//  RESTRequests
//
//  Created by Леонид on 18.06.2021.
//

import Foundation
import Alamofire

//специально вынесены как глобальные переменны, но любые ссылки в запросы лучше вставлять как аргумент функции. Тут так сделано чисто в образовательных целях
let getURL = "https://jsonplaceholder.typicode.com/posts/1"
let postURL = "https://jsonplaceholder.typicode.com/posts"

class URLNetworking {
    
    func getRequest (completion: @escaping (_ result: String)->()){
        guard let url = URL(string: getURL) else { return }//создание URL-переменной из строки
        
        let session = URLSession.shared//инициализация сессии
        session.dataTask(with: url) { (data, response, error) in //запуск сессии
            guard let data = data, let response = response as? HTTPURLResponse else { return } //проверка получения данных и ответа в формате респонса
            if response.statusCode != 200 {//если код не ОК, то отправка на экран данных об ошибке
                DispatchQueue.main.async {
                    completion("Статус запроса:\(response.statusCode). Что значит что полученных данных не поступило :(")
                }
            } else { // если всё ОК, то декодирование данных по модели из структуры
                do {
                    let decoder = JSONDecoder()
                    let jsonString = try decoder.decode(JsonGetModel.self, from: data)
                    DispatchQueue.main.async { // отправка полученных данных в асинхронный поток для отображения на главном экране
                        completion("Полученный JSON-GET. \n userID:\(jsonString.userId)\n id:\(jsonString.id)\n title:\(jsonString.title)\n body:\(jsonString.body)")
                    }
                } catch { // выше идет трай, если он прогорел – отображаем это на главном экране
                    DispatchQueue.main.async {
                        completion("Произошла ошибка при обработки JSON-GET:\(error)")
                    }
                }
            }
            
        }.resume()
    }
    
    func postRequest (completion: @escaping (_ result: String)->()){
        guard let url = URL(string: postURL) else { return }
        let data: [String: Any] = ["postID":157, "chars":"IDDQD_osma","doom":"Kruto ochen!"]
        
        //создание запроса
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //наполнение тела запроса
        guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
        request.httpBody = httpBody
        
        //инициализация сессии
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            if response.statusCode != 201 {//если код не Created, то отправка на экран данных об ошибке
                DispatchQueue.main.async {
                    completion("Статус запроса:\(response.statusCode). Что значит что полученных данных не поступило :(")
                }
            } else {
                do{
                    let jsonDecode = JSONDecoder()
                    let jsonStrings = try jsonDecode.decode(JsonPostModel.self, from: data)
                    DispatchQueue.main.async {
                    completion("Полученный JSON-POST.\n postID:\(jsonStrings.postID)\n chars:\(jsonStrings.chars)\n doom: \(jsonStrings.doom)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion("Произошла ошибка при обработки JSON-POST:\(error)")
                    }
                }
            }
        }.resume()
    }
}

//Лучше вынести класс ниже в отдельный файл, но в образовательных целях они остаются в одном, так как обеспечивают идентичный функционал
class AlamofireNetworking {
    func getRequest (completion: @escaping (_ result: String)->()){
        guard let url = URL(string: getURL) else { return }
        //запрос сразу разбирается в нужную нам модель. Можно, конечно, загонять через responseJSON, и копошится в нём
        AF.request(url, method: .get).responseDecodable(of: JsonGetModel.self) { (response) in
            switch response.result {
            
            case .success(let jsonString):
                DispatchQueue.main.async { // отправка полученных данных в асинхронный поток для отображения на главном экране
                    completion("Полученный JSON-AF-GET. \n userID:\(jsonString.userId)\n id:\(jsonString.id)\n title:\(jsonString.title)\n body:\(jsonString.body)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion("Произошла ошибка при обработки JSON-AF-GET:\(error)")
                }
            }
        }
        
    }
    
    func postRequest (completion: @escaping (_ result: String)->()){
        guard let url = URL(string: postURL) else { return }
        let data: [String: Any] = ["postID":99, "chars":"IDDQD","doom":"Kruto!"]
        
        //Важный момент! Залип на минут десять из-за того, что Alamofire отправлял postID как String, а не как Int. Надо было указать кодирование!
        AF.request(url, method: .post, parameters: data, encoding: JSONEncoding.default).responseDecodable(of: JsonPostModel.self){ (response) in
            switch response.result {
            
            case .success(let result):
                DispatchQueue.main.async {
                    completion("Полученный JSON-AF-POST.\n postID:\(result.postID)\n chars:\(result.chars)\n doom: \(result.doom)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion("Произошла ошибка при обработки JSON-AF-POST:\(error)")
                }
            }
        }
    }
}
