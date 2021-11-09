//
//  WebServiceHelper.swift
//  CarHailer
//
//  Created by Nikunj on 06/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import Foundation




final class NetworkManager {

  var films: [PPData] = []
  private let domainUrlString = "https://swapi.co/api/"
  
  func fetchFilms(completionHandler: @escaping ([PPData]) -> Void) {
    let url = URL(string: URL_PrivacyPolicy)!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching films: \(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(response)")
        return
      }

      if let data = data,
        let filmSummary = try? JSONDecoder().decode(PrivacyPolicyResponse.self, from: data) {
        print(filmSummary)
        print(data)
        completionHandler(filmSummary.Data ?? [])
      }
    })
    task.resume()
  }

  
}








struct PrivacyPolicyResponse: Codable {
  let is_valid: String?
  let Status: String?
  let Data: [PPData]?
}

struct PPData: Codable {
  let id: String?
    let title: String?
    let description: String?
}
