//
//  Country APIClient.swift
//  2017_11_30 Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation

struct CountryAPIClient {
    private init() {}
    static let manager = CountryAPIClient()
    func getCountries(from URLStr: String, completionHandler: @escaping ([Country])->Void, errorHandler: @escaping (AppError)-> Void ) -> Void {
        guard let url = URL(string: URLStr) else{
            errorHandler(.badURL)
            return
        }
        let completion: (Data)-> Void = {(data: Data) in
            do{
            let countries = try JSONDecoder().decode([Country].self, from: data)
                completionHandler(countries)
            }
            catch{
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: {print($0)})
        
    }
}
