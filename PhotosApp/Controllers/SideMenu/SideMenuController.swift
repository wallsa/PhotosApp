//
//  SideMenuController.swift
//  PhotosApp
//
//  Created by Wallace Santos on 24/05/23.
//

import UIKit

let sideMenuCellIdentifier = "defaultTableViewCell"

enum SideMenuOptions:Int,CaseIterable{
    case options
    case loggout
    
    var description:String{
        switch self {
        case .options: return "Options"
        case .loggout: return "Log Out"
        }
    }
    var image:String{
        switch self {
        case .options: return "gear"
        case .loggout: return "arrow.left.square"
        }
    }
}

protocol SideMenuDelegate:AnyObject{
    func sideMenuOptionPressed(_ option:SideMenuOptions)
}

class SideMenuController: UITableViewController {

//MARK: - Properties
    
    private let user:User
    
    weak var delegate:SideMenuDelegate?
    
    private lazy var sideMenuHeader:SideMenuViewHeader = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        let view = SideMenuViewHeader(user: user, frame: frame)
        return view
    }()

//MARK: - Lifecycle
    init(user:User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view.backgroundColor = .darkGray
    }

//MARK: - API

//MARK: - Helper Functions
    func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sideMenuCellIdentifier)
        tableView.tableHeaderView = sideMenuHeader
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
    }

//MARK: - Selectors

}

//MARK: - TableView DataSource and Delegate
extension SideMenuController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SideMenuOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuCellIdentifier, for: indexPath)
        guard let option = SideMenuOptions(rawValue: indexPath.row) else {return UITableViewCell()}
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = option.description
            content.image = UIImage(systemName: option.image)
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = option.description
            cell.tintColor = .darkPurple
            cell.imageView?.image = UIImage(systemName: option.image)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let option = SideMenuOptions(rawValue: indexPath.row) else {return}
        delegate?.sideMenuOptionPressed(option)
    }

}
