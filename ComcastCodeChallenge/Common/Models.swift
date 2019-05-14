//
//  Models.swift
//  ComcastCodeChallenge
//
//  Created by Eladio Alvarez Valle on 5/14/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import Foundation

struct ServerDataResponseModel: Codable {
    
    var ImageIsLogo : Int
    var AbstractSource : String
    var Heading : String
    var Definition : String
    var Infobox : String
    var Image : String
    var `Type` : String
    var DefinitionURL : String
    var AbstractURL : String
    var Answer : String
    var Results : [String]
    var Abstract : String
    var AbstractText : String
    var Redirect : String
    var RelatedTopics: [RelatedTopic]

}

struct RelatedTopic : Codable {
    
    var FirstURL : String
    var Result : String
    var Text : String
    var Icon : Icon
}

struct Icon : Codable {
    
    var Height : String
    var Width : String
    var URL : String
}
