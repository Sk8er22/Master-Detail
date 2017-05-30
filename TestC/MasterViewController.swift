//
//  MasterViewController.swift
//  TestC
//
//  Created by PEDRO ARMANDO MANFREDI on 23/5/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MasterViewController: UITableViewController {
    
    //definimos variables
    var detailViewController: DetailViewController? = nil //declaración del detailView
    var posts = [ClassPosts]() //arrays de posts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension;
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)//personalizamos la navigation Bar
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        //hacemos la consulta al server
        self.request()

        //definimos el split
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Segues PASANDO DATOS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.comments.removeAll()
                controller.postSelected = indexPath.row + 1 // sumo uno para que coincida el selected con la página en el get
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.post = self.posts[indexPath.row] // Solamente paso el post seleccionado
                controller.tableView.setNeedsLayout()
                controller.tableView.layoutIfNeeded()
                controller.request()

            }
        }
    }
    
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    //devuelve la celda personalizada para cada row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPosts", for: indexPath) as! CellPosts
        let post = posts[indexPath.row]
        cell.titlePosts.text = post.title
        let textBodyCell = post.body
        let lngString = textBodyCell as NSString
        if lngString.length > 0
        {
            cell.bodyPosts.text = lngString.substring(with: NSRange(location: 0, length: lngString.length > 80 ? 80 : lngString.length)) + "..."
        }
        return cell
    }
    
    // REQUEST WEB
    func request(){
        Alamofire.request("https://jsonplaceholder.typicode.com/posts") .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in 0..<json.count{
                    let post = ClassPosts(dictionary: json[i].dictionaryObject! as [String : AnyObject])
                    self.posts.append(post)
                }
                DispatchQueue.main.async() {
                    UIView.transition(with: self.tableView, duration: 1.0, options: .transitionCurlDown, animations: {self.tableView.reloadData()}, completion: nil)
                    //Para cargar la primera celda correctamente
                    self.tableView.setNeedsLayout()
                    self.tableView.layoutIfNeeded()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

