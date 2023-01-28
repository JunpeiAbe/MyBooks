//
//  BooksError.swift
//  MyBooks
//
//  Created by Junpei  on 2023/01/30.
//

import Foundation

enum BooksError: Error, LocalizedError {
    case invalidURL
    case serverError
    case invalidData
    case unkown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "不正なURLです。"
        case .serverError:
            return "サーバーでエラーが発生しました。後でもう一度やり直してください。"
        case .invalidData:
            return "書籍データが無効です。後でもう一度やり直してください。"
        case .unkown(let error):
            return error.localizedDescription
        }
    }
}
