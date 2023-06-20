//
//  UserStatusController.swift
//  PhotosApp
//
//  Created by Wallace Santos on 19/06/23.
//

import UIKit

class UserStatusController:UITableViewController{
//MARK: - Properties
    
    let header = ProfileStatusFilterHeaderView()
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
//MARK: - API
    
    private func fetchFollowers(){
        UserService.fetchFollowings { followings in
            
        }
    }
    
//MARK: - Helper Functions
    
    fileprivate func configure(){
        tableView.tableHeaderView = header
        header.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
    }
    
//MARK: - Selectors
}

//MARK: - UITableView Delegate and DataSource

extension UserStatusController{
  
    
}

//MARK: - Header Delegate
extension UserStatusController:ProfileStatusFilterHeaderViewDelegate{
    
    func optionSelected(_ option: ProfileStatusFilterOptions) {
        <#code#>
    }
}
