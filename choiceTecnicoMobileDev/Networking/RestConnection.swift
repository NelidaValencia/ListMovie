//
//  RestConnection.swift
//  choiceTecnicoMobileDev
//
//  Created by Nelida Valencia on 19/07/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit


struct RestConnection {
    
    private let LOGIN = "mobile/auth"
    private let LIST = "mobile/data"
    
    func login(sub : String, callback: @escaping( _ token: String?, _ type : String?, _ statusCode: Int?)-> Void) {
        let apiMethod = IP + LOGIN
        print("SUB", sub)
        let parametersfrom: Parameters = ["sub": sub]
        
        Alamofire.request(apiMethod, method: .post , parameters: parametersfrom, encoding: JSONEncoding.default).responseString { (response) in
            print("RESPONSE", response)
            if let code = response.response?.statusCode, code == 200 {
                let jsonData = Data(response.result.value!.utf8)
                do {
                    let decoderdec = JSONDecoder()
                    decoderdec.keyDecodingStrategy = .convertFromSnakeCase
                    let userResponse = try decoderdec.decode(LoginResponse.self, from: jsonData)
                    callback(userResponse.token, userResponse.type, response.response?.statusCode)
                } catch let error {
                    print(error)
                }
            } else {
                callback("","",response.response?.statusCode)
            }
        }
    }
        
    func listMovies(type : String, token: String, callback: @escaping(_ data: [MovieR]?, _ title: String?, _ imageURL: String?, _ videoURL: String?, _ descripcion: String?, _ typeData: String?, _ titledata : String?, _ status: Int?) -> Void) {
        
        let apiMethod = IP + LIST
        let headers: HTTPHeaders = ["Authorization": "\(type) " + "\(token)"]
        
        Alamofire.request(apiMethod, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers) .responseString { (response) in
            print(response)
            let jsonData = Data(response.result.value!.utf8)
            do {
                let decoderdec = JSONDecoder()
                decoderdec.keyDecodingStrategy = .convertFromSnakeCase
                let movieResponse  = try decoderdec.decode([MovieR].self, from: jsonData)
                callback(movieResponse,"","","","","","",200)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func Movies(type : String, token: String, callback: @escaping(_ data: [MovieR]? , _ detail: [DetailMovie]?,_ message : String?, _ status: Int?) -> Void) {
        
        let apiMethod = IP + LIST
        let headers: HTTPHeaders = ["Authorization": "\(type) " + "\(token)"]
        
        Alamofire.request(apiMethod, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers) .responseString { (response) in
            
            print(response)
            
            if let data = response.data {
                let json = JSON(data)
                if let code = response.response?.statusCode, code == 200 {
                    
                    var detail : [DetailMovie] = []
                    var movieArray : [MovieR] = []
                    
                    for itemOne in json.arrayValue {
                        for item in itemOne["items"].arrayValue {
                            detail.append(DetailMovie(title: item["title"].string,
                                                      imageUrl: item["imageUrl"].string,
                                                      videoUrl: item["videoUrl"].string,
                                                      description: item["description"].string))
                        }
                        movieArray.append(MovieR(title: itemOne["title"].string,
                                                 type: itemOne["type"].string,
                                                 items: detail))
                    }
                    print("MOVIE ARRAY RESPONSE", movieArray)
                    print("MOVIE DETAIL RESPONSE", detail)
                    callback(movieArray,detail,"", code)
                    
                }else if let code = response.response?.statusCode, code == 401 {
                    callback([], [],nil, code)
                } else {
                    callback([], [],"ERROR DE SERVIDOR", 0)
                }
            }else {
                callback([], [],"PARAMETRO NULO", 0)
            }
        }
    }
}
