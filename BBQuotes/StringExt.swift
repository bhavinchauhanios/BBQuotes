//
//  StringExt.swift
//  BBQuotes
//
//  Created by Bhavin Chauhan on 02/08/25.
//

extension String {
    
    /// Removes all spaces from the string.
    func removeSpaces() -> String {
        replacingOccurrences(of: " ", with: "")
    }
    
    /// Returns a lowercased version of the string with all spaces removed.
    func removeCaseAndSpaces() -> String {
        lowercased().replacingOccurrences(of: " ", with: "")
    }
}
