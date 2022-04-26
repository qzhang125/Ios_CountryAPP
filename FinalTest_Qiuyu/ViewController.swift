//
//  ViewController.swift
//  FinalTest_Qiuyu
//
//  Created by Qiuyu Zhang on 2022-04-15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var countryTableView: UITableView!
    var countryCollection:[CountryObject] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "myCell", for:indexPath)
        cell.textLabel!.text = countryCollection[indexPath.row].countryName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(countryCollection[indexPath.row].countryName)
        guard let infoScreen = storyboard?.instantiateViewController(withIdentifier: "infoScreen") as? InfoViewController else{
            print("Error: cant find a screen")
            return
        }
        
        let countryInfoNode:CountryObject? = CountryObject(name: countryCollection[indexPath.row].countryName, code: countryCollection[indexPath.row].countryCode, capital: countryCollection[indexPath.row].capital, population: countryCollection[indexPath.row].population)
        infoScreen.infoNode = countryInfoNode
        show(infoScreen, sender: self)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.delegate = self
        countryTableView.dataSource = self
        getCountries()
        // Do any additional setup after loading the view.
    }
    
    private func getCountries(){
        let apiEndPoint = "https://restcountries.com/v2/all"
        guard let apiURL = URL(string:apiEndPoint) else {
            print("Could not convert the string endpoint to an URL object")
            return
        }
        
        URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            if let err = error {
                print("Error occured while fetching data from api")
                print(err)
                return
            }
            
            //Got data back from the country api
            
            if let jsonData = data {
                do{
                    let decoder = JSONDecoder()
                    let decodedItem:[Country] = try decoder.decode([Country].self, from: jsonData)
                    DispatchQueue.main.async {
                        for i in 0..<decodedItem.count{
                            let countryObject = CountryObject(name: decodedItem[i].name, code: decodedItem[i].alpha3Code, capital: decodedItem[i].capital, population: decodedItem[i].population)
                            self.countryCollection.append(countryObject)
                            self.countryTableView.reloadData()
                            //print(self.countryCollection[i].countryName)
                        }
                    }
                }catch let error{
                    print("Error occur during Json decoding")
                    print(error)
                }
            }
        }.resume()
    }
}



