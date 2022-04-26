//
//  InfoViewController.swift
//  FinalTest_Qiuyu
//
//  Created by Qiuyu Zhang on 2022-04-15.
//
import CoreData
import UIKit

class InfoViewController: UIViewController {
    var infoNode:CountryObject? = nil
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //Create a request to fetch the data, check the duplicate info in fav core database
    let checkDuplicateRequest:NSFetchRequest<FAVOURITE> = FAVOURITE.fetchRequest()
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblCapital: UILabel!
    
    @IBOutlet weak var lblCode: UILabel!
    
    @IBOutlet weak var lblPopulation: UILabel!
    
    @IBOutlet weak var lblWarning: UILabel!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let infoObject = infoNode {
            lblName.text = infoObject.countryName
            lblCapital.text = "Capital: \(infoObject.capital)"
            lblCode.text = "Country Code: \(infoObject.countryCode)"
            lblPopulation.text = "Population: \(infoObject.population)"
        }else{
            lblWarning.text = "Sorry, no country information found"
            saveBtn.isEnabled = false
            return
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        //Filter duplicate country
        if let infoObject = infoNode{
            checkDuplicateRequest.predicate = NSPredicate(format: "name == %@", infoObject.countryName)
            do{
                //Fetch all of the favourite countries from core database
                let results:[FAVOURITE] = try self.context.fetch(checkDuplicateRequest)
                
                if(results.count == 0){
                    //No duplicate country info
                    do {
                        let fav = FAVOURITE(context: self.context)
                        fav.name = infoObject.countryName
                        fav.population = Int64(infoObject.population)
                        
                        try self.context.save()
                        print("Successfully saved")
                        
                    }catch{
                        print("Saved failed")
                        return
                    }
                    //Display a alert box
                    let box1 = UIAlertController(title: "Country Saved", message: "The information of \(infoObject.countryName) has been saved successfully", preferredStyle: .alert)
                    box1.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    //Show the alert box
                    self.present(box1, animated:true)
                    
                }else if(results.count != 0){
                    //Display alter box for error message
                    let box2 = UIAlertController(title: "Error", message: "The information of \(infoObject.countryName) can only be saved once", preferredStyle: .alert)
                    box2.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(box2, animated:true)
                    print("Stored a duplicate country")
                }
                
            }catch{
                print("Error while fetching")
            }
        }else{
            print("Error Node")
            return
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
