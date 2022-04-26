//
//  Country.swift
//  FinalTest_Qiuyu
//
//  Created by Qiuyu Zhang on 2022-04-15.
//

import Foundation
//Country Model Class
struct Country:Codable{
    var name: String
    var alpha3Code: String
    var capital: String
    var population: Int
    
    enum Codingkeys:String, CodingKey{
        case name="name"
        case alpha3Code="alpha3Code"
        case capital="capital"
        case population="population"
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try response.decodeIfPresent(String.self, forKey: CodingKeys.name) ?? "No country name given"
        self.alpha3Code = try response.decodeIfPresent(String.self, forKey: CodingKeys.alpha3Code) ?? "No country code given"
        self.capital = try response.decodeIfPresent(String.self, forKey: CodingKeys.capital) ?? "No capital given"
        self.population = try response.decodeIfPresent(Int.self, forKey: CodingKeys.population) ?? 0
    }
}
