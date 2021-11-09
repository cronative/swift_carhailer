//
//  CountryCodeSelectVC.swift
//  CarHailer
//
//  Created by Apple on 08/12/20.
//  Copyright © 2020 Nikunj M. All rights reserved.
//

import UIKit
protocol CountryCodeDelegate {
  func onCountryCodeSelected(objDic : [String : Any])
}

class CountryCodeSelectVC: UIViewController ,UISearchBarDelegate{
@IBOutlet weak var tblView: UITableView!
      @IBOutlet var searchBar: UISearchBar!
    var isSearch : Bool = false
    var delegate : CountryCodeDelegate!
    
    var filterData : [[String : String]] = COUNTRIES_CODE
    override func viewDidLoad() {
        super.viewDidLoad()
 tblView.tableFooterView = UIView()
//        self.filterData = COUNTRIES_CODE.mutableCopy() as! NSMutableArray
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.delegate = self
    }
    
    @IBAction func onClickClose(sender: UIButton){
        
           self.dismiss(animated: true, completion:nil)
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: UISearchbar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
//        let resultPredicate = NSPredicate(format: "name contains[c] %@", searchText)
//        self.filterData = COUNTRIES_CODE.filtered(using: resultPredicate) as! NSMutableArray
        
        filterData = searchText.isEmpty ? COUNTRIES_CODE  : COUNTRIES_CODE.filter{ $0.values.contains(searchText)}
        self.tblView.reloadData()
    }
    


}

//MARK:- UITableViewDataSource Methods
   extension CountryCodeSelectVC: UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
       }
        
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell :CountryCodeCell = tableView.dequeueReusableCell(withIdentifier: "CountryCodeCell") as! CountryCodeCell
        cell.showDataInCell(objDic: (filterData[indexPath.row]))
   //        cell.lblTitle?.text = leftMenu[indexPath.row]
           cell.selectionStyle = .none
           return cell
       }
   }

   //MARK:- UITableViewDelegate Methods
   extension CountryCodeSelectVC: UITableViewDelegate {
       
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           return UIView()
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 0
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.onCountryCodeSelected(objDic: (filterData[indexPath.row]))
        self.dismiss(animated: true, completion:nil)
       }
       
      
   }
