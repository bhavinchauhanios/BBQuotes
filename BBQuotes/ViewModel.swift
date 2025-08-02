//
//  ViewModel.swift
//  BBQuotes
//
//  Created by Bhavin Chauhan on 02/08/25.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }

    // ✅ Published properties so SwiftUI observes them
    @Published private(set) var status: FetchStatus = .notStarted
    @Published var quote: Quote
    @Published var character: Char

    private let fetcher = FeatchService()

    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Load initial JSON data (fallback content)
        let quoteURL = Bundle.main.url(forResource: "samplequote", withExtension: "json")!
        let quoteData = try! Data(contentsOf: quoteURL)
        self.quote = try! decoder.decode(Quote.self, from: quoteData)

        let charURL = Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!
        let charData = try! Data(contentsOf: charURL)
        self.character = try! decoder.decode(Char.self, from: charData)
    }

    func getData(for show: String) async {
        status = .fetching

        do {
            let fetchedQuote = try await fetcher.fetchQuote(from: show)
            let fetchedCharacter = try await fetcher.fetchCharacter(fetchedQuote.character)
            let fetchedDeath = try await fetcher.fetchDeath(for: fetchedCharacter.name)

            quote = fetchedQuote
            var characterWithDeath = fetchedCharacter
            characterWithDeath.death = fetchedDeath
            character = characterWithDeath

            status = .success
        } catch {
            status = .failed(error: error)
        }
    }
}

