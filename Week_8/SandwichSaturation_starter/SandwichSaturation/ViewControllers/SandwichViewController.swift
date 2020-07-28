//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
  func saveNewSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
    
  var appDelegate: AppDelegate!
  var viewContext: NSManagedObjectContext!
    
  let searchController = UISearchController(searchResultsController: nil)
  //var sandwiches = [SandwichData]()
  //var filteredSandwiches = [SandwichData]()
  var sandwiches = [Sandwich]()
  var filteredSandwiches = [Sandwich]()
    
  //MARK: Constants
  let indexScopeKey = "KEY_INDEX_SCOPE"
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    appDelegate = UIApplication.shared.delegate as? AppDelegate
    viewContext = appDelegate.persistentContainer.viewContext
    
    loadSandwiches()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    searchController.searchBar.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let indexScopeSaved = UserDefaults.standard.integer(forKey: indexScopeKey)
    searchController.searchBar.selectedScopeButtonIndex = indexScopeSaved
  }
    
  func fetchSandwichesFromLocalDB () -> [Sandwich] {
    let request = NSFetchRequest<Sandwich>(entityName: "Sandwich")
    do {
      return try viewContext.fetch(request)
    } catch let error {
      print(error.localizedDescription)
    }
    return []
  }
  
  func loadSandwiches() {
    let sandwichesFromDB = fetchSandwichesFromLocalDB()
    if sandwichesFromDB.count == 0 {
      guard let sandwichesJSONURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else { return }
      do {
        let decoder = JSONDecoder()
        let sandwichesData = try Data(contentsOf: sandwichesJSONURL)
        let sandwiches = try decoder.decode([SandwichData].self, from: sandwichesData)
        for sandwich in sandwiches {
          let coreDataSandwich = persistSandwich(sandwich)
            self.sandwiches.append(coreDataSandwich)
        }
      } catch let error {
        print(error)
      }
    } else {
        self.sandwiches = sandwichesFromDB
    }
  }
    
  func persistSandwich(_ sandwich: SandwichData) -> Sandwich {
    let sandwichCoreData = Sandwich(entity: Sandwich.entity(), insertInto: viewContext)
    sandwichCoreData.name = sandwich.name
    sandwichCoreData.imageName = sandwich.imageName
    sandwichCoreData.sauceAmount = sandwich.sauceAmount.rawValue
    appDelegate.saveContext()
    return sandwichCoreData
  }
    
  func deleteSandwich(_ sandwich: Sandwich) {
    viewContext.delete(sandwich)
    appDelegate.saveContext()
  }

  func saveNewSandwich(_ sandwichData: SandwichData) {
    let sandwich = persistSandwich(sandwichData)
    sandwiches.append(sandwich)
    tableView.reloadData()
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String, sauceAmount: SauceAmount? = nil) {
//    filteredSandwiches = sandwiches.filter { (sandwhich: SandwichData) -> Bool in
//      let doesSauceAmountMatch = sauceAmount == .any || sandwhich.sauceAmount == sauceAmount
//
//      if isSearchBarEmpty {
//        return doesSauceAmountMatch
//      } else {
//        return doesSauceAmountMatch && sandwhich.name.lowercased()
//          .contains(searchText.lowercased())
//      }
//    }
//
//    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
    
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : sandwiches.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = isFiltering ?
      filteredSandwiches[indexPath.row] :
      sandwiches[indexPath.row]

    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.description

    return cell
  }
    
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let sandwich = sandwiches[indexPath.row]
      sandwiches.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      deleteSandwich(sandwich)
    }
  }
    
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    UserDefaults.standard.set(selectedScope, forKey: indexScopeKey)
  }
}

