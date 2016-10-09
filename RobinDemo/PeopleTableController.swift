//
//  ViewController.swift
//  RobinDemo
//
//  Created by Jeremy Kelleher on 10/8/16.
//  Copyright © 2016 JKProductions. All rights reserved.
//

import UIKit

let accessToken = "DzyH5sI60rcCeEqyid6Y21jETxXIYgl20iLYgv8WtCnRqPqXkJBuYMRinW1oTeu2Ol8utsqiUrInb0hM7el7kAcLf0osiGqKlNqnhI6zNur5g1oYpnl5hWY0secj1f4x"
let baseURL = URL(string: "https://api.robinpowered.com/v1.0/")
let headers = ["content-type":"application/json", "Authorization": "Access-Token \(accessToken)"]

class PeopleTableController: UIViewController {

    @IBOutlet weak var peopleTable: UITableView!
    var peopleInRoom: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTable.delegate = self
        peopleTable.dataSource = self
        loadPeople()
    }
    
    func loadPeople() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = headers
        let session = URLSession(configuration: sessionConfig)
        
        let space = 763 // Room 220
        let presenceEndpoint = "spaces/\(space)/presence"
        guard let fullURL = baseURL?.appendingPathComponent(presenceEndpoint) else { return }
        
        let task = session.dataTask(with: fullURL) { (data, response, error) in
            do {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: .init(rawValue: 0)) as? [String: AnyObject] else { return }
                guard let people = json["data"] as? [[String: AnyObject]] else { return }
                self.peopleInRoom.removeAll()
                for person in people {
                    guard let user = person["user"] as? [String: AnyObject] else { return }
                    guard let name = user["name"] as? String else { return }
                    self.peopleInRoom.append(name)
                }
                if !people.isEmpty {
                    DispatchQueue.main.async {
                        self.peopleTable.reloadData()
                    }
                }
            } catch let error as NSError {
                print("Error parsing results: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}

