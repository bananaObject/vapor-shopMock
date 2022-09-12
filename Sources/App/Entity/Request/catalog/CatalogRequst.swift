//
//  CatalogRequst.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Vapor

struct CatalogRequst: Content {
    let page_number : Int
    let id_category : Int?
}
