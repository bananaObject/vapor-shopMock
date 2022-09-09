//
//  CatalogResponse.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Vapor

struct CatalogResponse: Content {
    let page_number : Int
    let max_page: Int
    let products : [ProductResponse]
}
