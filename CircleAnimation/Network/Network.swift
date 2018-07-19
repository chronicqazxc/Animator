//
//  Network.swift
//  CircleAnimation
//
//  Created by Hsiao, Wayne on 6/30/18.
//  Copyright © 2018 Hsiao, Wayne. All rights reserved.
//

import UIKit

enum Constant: String {
    case castle = "https://pbs.twimg.com/profile_images/841697554551230465/Du1SzL8X_400x400.jpg"
}

extension UIImage {
    
    struct LoadImageError: Error {
        enum ErrorKind {
            case invalidPath
            case responseError
            case parseError
        }
        
        let line: Int
        let kind: ErrorKind
    }
    
    static func loadImageUsing(path: Constant, completeHandler: @escaping (UIImage?, Error?)->()) {
        guard let url = URL(string: path.rawValue) else {
            let pathError = LoadImageError(line: 37, kind: .invalidPath)
            completeHandler(nil, pathError)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completeHandler(nil, error)
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data,
                    let image = UIImage(data: data) else {
                        let parseError = LoadImageError(line: 50, kind: .parseError)
                        completeHandler(nil, parseError)
                        return
                }
                
                completeHandler(image, nil)
            }
            }.resume()
    }
}
