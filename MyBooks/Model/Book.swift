//
//  Books.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/09.
//

import Foundation
import SwiftUI

struct Items:Decodable{
    let items:[Book]
}

struct Book:Decodable,Identifiable{
    let id:String
    let volumeInfo:VolumeInfo
}

struct VolumeInfo:Decodable{
    let title:String?
    let authors:[String]?
    let publisher:String?
    let publishedDate:String?
    let description:String?
    let imageLinks:ImageLinks?
}

struct ImageLinks:Decodable{
    let smallThumbnail:String?
    let thumbnail:String?
    
    var imageUrl: URL? {
        return URL(string: thumbnail ?? "")
    }
}

var mockData = Book(id: "", volumeInfo: VolumeInfo(title: "鬼滅の刃", authors: ["吾峠呼世晴"], publisher: "集英社", publishedDate: "2021.10.10", description: "大正時代、人を喰らう鬼が街に蔓延っていた。炭焼きの少年、竈門炭治郎と妹のねずこは家族を鬼に殺された過去を持つ。鬼に復讐するための兄弟の旅が始まる。", imageLinks: ImageLinks(smallThumbnail: "", thumbnail: "")))
