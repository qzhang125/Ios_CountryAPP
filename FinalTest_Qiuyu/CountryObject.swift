//
//  CountryObject.swift
//  FinalTest_Qiuyu
//
//  Created by Qiuyu Zhang on 2022-04-15.
//

import Foundation
struct CountryObject{
    var countryName: String
    var countryCode: String
    var capital: String
    var population: Int
    
    init(name:String, code:String, capital:String, population: Int){
        self.countryName = name
        self.countryCode = code
        self.capital = capital
        self.population = population
    }
}
