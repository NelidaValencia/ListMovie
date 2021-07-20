//
//  BusinessController.swift
//  choiceTecnicoMobileDev
//
//  Created by Nelida Valencia on 19/07/21.
//

import Foundation

class BusinessController {
    
    var restConnection = RestConnection()
    
    func executeLogin(sub: String, callback: @escaping(_ result: Bool, _ token: String?, _ type : String? ) -> Void){
        restConnection.login(sub: sub) { (token, type, status) in
            if status == 200{
                callback(true, token , type)
            }else{
                callback(false, "" , "")
            }
        }
    }
    
    func executeListMovie(type : String, token: String, callback: @escaping(_ data: [MovieR]?,_ result : Bool, _ title: String?, _ imageURL: String?, _ videoURL: String?, _ descripcion: String?, _ typeData: String?, _ titledata : String?, _ status: Int?) -> Void) {
        
        restConnection.listMovies(type: type, token: token) { (data, title, imageURL, videoURL, descripcion, typeData, titledata, status) in
            if status == 200 {
                callback(data, true, "","","","","","",status)
            }else{
                callback(data, false, "","","","","","",status)
            }
            
        }
        
    }
    
    func executeMovies(type : String, token: String, callback: @escaping(_ data: [MovieR]? , _ detail: [DetailMovie]?,_ result: Bool, _ message : String?, _ status: Int?) -> Void) {
        
        restConnection.Movies(type: type, token: token) { (data, detail, message, status) in
            if status == 200{
                callback(data,detail,true,message,status)
            }else{
                callback([],[],false,message,status)
            }
        }
        
    }
}
