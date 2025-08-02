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
        case successQuote
        case successEpisode
        case failed(error: Error)
    }

    // ✅ Published properties so SwiftUI observes them
    @Published private(set) var status: FetchStatus = .notStarted
    @Published var quote: Quote
    @Published var character: Char
    @Published var episode: Episode

    private let fetcher = FetchService()

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

        let episodeURL = Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!
        let episodeData = try! Data(contentsOf: episodeURL)
        self.episode = try! decoder.decode(Episode.self, from: episodeData)
        
    }

    func getQuoteData(for show: String) async {
        status = .fetching

        do {
            let fetchedQuote = try await fetcher.fetchQuote(from: show)
            let fetchedCharacter = try await fetcher.fetchCharacter(fetchedQuote.character)
            let fetchedDeath = try await fetcher.fetchDeath(for: fetchedCharacter.name)

            quote = fetchedQuote
            var characterWithDeath = fetchedCharacter
            characterWithDeath.death = fetchedDeath
            character = characterWithDeath

            status = .successQuote
        } catch {
            status = .failed(error: error)
        }
    }
    
    func getEpisode(for show: String) async {
        status = .fetching

        do {

            if let unwrappedEpisodes = try await fetcher.fetchEpisode(for: show){
                episode = unwrappedEpisodes
            }

            status = .successEpisode
        } catch {
            status = .failed(error: error)
        }
    }
    
}

