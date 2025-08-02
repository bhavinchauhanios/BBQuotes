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
    let death : Death?
    
}
