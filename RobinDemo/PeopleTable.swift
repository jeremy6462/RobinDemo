//
//  PeopleTable.swift
//  RobinDemo
//
//  Created by Jeremy Kelleher on 10/8/16.
//  Copyright © 2016 JKProductions. All rights reserved.
//

import UIKit

extension PeopleTableController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleInRoom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
        cell.name.text = peopleInRoom[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

class PersonCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
}
