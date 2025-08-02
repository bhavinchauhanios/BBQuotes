//
//  FeatchService.swift
//  BBQuotes
//
//  Created by Bhavin Chauhan on 01/08/25.
//

import Foundation

struct FeatchService{
    
    private enum FeatchError : Error{
        case badResponse
    }
    
    private let baseURL =  URL(string: "https://breaking-bad-api-six.vercel.app/api/")!
    
    //https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    func fetchQuote(from show:String) async throws -> Quote {
        
        //BuildFetch URL
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        print(fetchURL)
        //Fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle Response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FeatchError.badResponse
        }
        
        // Decode Data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return Quote
        return quote
        
    }
    
    func fetchCharacter(_ name: String) async throws -> Char{
        
        //BuildFetch URL
        let quoteURL = baseURL.appending(path: "characters")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        //Fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle Response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FeatchError.badResponse
        }
        
        // Decode Data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Char].self, from: data)
        
        // Return Quote
        return characters[0]
        
    }
    
    func fetchDeath(for character:String) async throws -> Death? {
        
        let fetchURL = baseURL.appending(path: "deaths")

        //Fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle Response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FeatchError.badResponse
        }
        
        // Decode Data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character{
                return death
            }
        }
        return nil
    }
    
}
