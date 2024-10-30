//
//  FavoriteInfoForCell.swift
//  NewsToDayApp
//
//  Created by user on 27.10.2024.
//

import UIKit

//Модель для избранных статей

struct FavoriteArticles: Codable, Equatable {
    let id: String?
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
   
}


