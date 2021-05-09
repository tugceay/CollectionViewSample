//
//  Meditation.swift
//  CollectionView
//
//  Created by Tugce Aybak on 8.05.2021.
//

import Foundation

struct Meditation : Codable {
    let title : String
    let subtitle : String
    let image : ImageModel
    let content : String
}

struct Story : Codable {
    let name : String
    let category : String
    let image : ImageModel
    let text : String
}

struct ImageModel : Codable {
    let small : String
    let large : String
}

struct DataModel : Codable {
    let isBannerEnabled : Bool!
    let meditations : [Meditation]
    let stories : [Story]
}
