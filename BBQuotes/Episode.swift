//
//  Episode.swift
//  BBQuotes
//
//  Created by Bhavin Chauhan on 02/08/25.
//

import Foundation

struct Episode: Decodable{
    
    let episode : Int
    let title : String
    let image : URL
    let synopsis : String
    let writtenBy : String
    let directedBy: String
    let airDate : String
    
    var seasonEpisode: String{
        "Season \(episode / 100) Episode \(episode & 100)"
    }
    
    enum CodingKeys: CodingKey {
        case episode
        case title
        case image
        case synopsis
        case writtenBy
        case directedBy
        case airDate
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.episode = try container.decode(Int.self, forKey: .episode)
        self.title = try container.decode(String.self, forKey: .title)
        self.image = try container.decode(URL.self, forKey: .image)
        self.synopsis = try container.decode(String.self, forKey: .synopsis)
        self.writtenBy = try container.decode(String.self, forKey: .writtenBy)
        self.directedBy = try container.decode(String.self, forKey: .directedBy)
        self.airDate = try container.decode(String.self, forKey: .airDate)
    }
    
}
