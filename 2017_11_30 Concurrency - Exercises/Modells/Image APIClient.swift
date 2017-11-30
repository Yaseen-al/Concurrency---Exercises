//
//  Image APIClient.swift
//  2017_11_30 Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
import UIKit
struct ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                guard let image = UIImage(data: data) else {
                    errorHandler(AppError.notAnImage)
                    return
                }
                completionHandler(image)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}
