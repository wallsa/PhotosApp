//
//  SearchController.swift
//  PhotosApp
//
//  Created by Wallace Santos on 24/05/23.
//

import UIKit

fileprivate let reuseIdentifier = "SearchProfilesCell"

class SearchController: UITableViewController {

//MARK: - Properties
    private var users : [User]?{
        didSet{
            tableView.reloadData()
        }
    }
    

//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchUsers()
    }
//MARK: - API
    
    func fetchUsers(){
        UserService.fetchUsers { users in
            self.users = users
        }
    }

//MARK: - Helper Functions

    fileprivate func configure(){
        navigationItem.title = "Explore"
        navigationController?.navigationBar.tintColor = .darkPurple
        tableView.register(SearchProfilesCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
    
    fileprivate func showProfile(withUser user:User){
        let profile = ProfileController(user: user)
        navigationController?.pushViewController(profile, animated: true)
    }

//MARK: - Selectors

    
}


//MARK: - UITableViewController - DataSource and Delegate

extension SearchController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchProfilesCell
        let user = users?[indexPath.row] 
        cell.user = user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let user = users?[indexPath.row] else {return}
        showProfile(withUser: user)
        
    }
    
    
}
