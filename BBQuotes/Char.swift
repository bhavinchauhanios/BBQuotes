//
//  Character.swift
//  BBQuotes
//
//  Created by Bhavin Chauhan on 01/08/25.
//

import Foundation

struct Char : Decodable{
    
    let name : String
    let birthday : String
    let occupations : [String]
    let images : [URL]
    let aliases : [String]
    let portrayedBy : String
    let status : String
    var death : Death?
    
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupations
        case images
        case aliases
        case portrayedBy
        case status
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.images = try container.decode([URL].self, forKey: .images)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        self.status = try container.decode(String.self, forKey: .status)
        
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deathData = try Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        death = try deathDecoder.decode(Death.self, from: deathData)
        
    }
    
}
