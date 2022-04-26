//
//  FavouriteViewController.swift
//  FinalTest_Qiuyu
//
//  Created by Qiuyu Zhang on 2022-04-17.
//
import CoreData
import UIKit

class FavouriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Create a request to fetch all the data stored in favourite core database
    let fetchAllRequest:NSFetchRequest<FAVOURITE> = FAVOURITE.fetchRequest()
    
    //Create a Favourite object array for the tableview on 3rd screen
    var favCollection:[FAVOURITE] = [];
    
    //Mark
    @IBOutlet weak var favTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(favCollection.count)
        return favCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: "favCell", for:indexPath) as! FavouriteTableViewCell
        let fav = favCollection[indexPath.row]
        cell.lblName.text = fav.name
        cell.lblPopulation.text = "\(fav.population)"
        if(fav.population > 38005238){
            cell.backgroundColor = UIColor.systemYellow
        }else{
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    //Delete country from fav
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        let deleteRequest:NSFetchRequest<FAVOURITE> = FAVOURITE.fetchRequest()
        deleteRequest.predicate = NSPredicate(format: "name == %@", favCollection[indexPath.row].name!)
        do{
            //print("Delete \(favCollection[indexPath.row].name), successfully")
            let results:[FAVOURITE] = try self.context.fetch(deleteRequest)
            let countryToDelete = results.first!
            self.context.delete(countryToDelete)
            try self.context.save()
            //Delete the data from class and core data base
            favCollection.remove(at: indexPath.row)
            //Delete from UI
            favTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.favTableView.reloadData()
        }catch{
            print("Error to delete")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do{
            //Fetch the favourite countries from coredata
            let favData:[FAVOURITE] = try self.context.fetch(self.fetchAllRequest)
            //Assign the countries into fav array
            self.favCollection = favData
            //Refresh the table
            self.favTableView.reloadData()
        }catch{
            print("Failed to fetch the fav data")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
            
        // Do any additional setup after loading the view.
        //Fetch all the data from fav core database
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
