//
//  MovieResponse.swift
//  choiceTecnicoMobileDev
//
//  Created by Nelida Valencia on 19/07/21.
//

import Foundation

//public struct MovieResponse : Codable {
//    let data : MovieR?
//}

public struct MovieR : Codable {
    var title : String? = ""
    var type : String? = ""
    var items : [DetailMovie]?
}

public struct DetailMovie : Codable {
    var title : String?
    var imageUrl : String?
    var videoUrl : String?
    var description : String?
}
