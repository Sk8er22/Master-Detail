//
//  DetailViewController.swift
//  TestC
//
//  Created by PEDRO ARMANDO MANFREDI on 23/5/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UITableViewController{
    
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var tableview: UITableView!
    var postSelected: Int = 1
    var comments = [ClassComments]()
    var post: ClassPosts?
    
    func configureView() {
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                self.request()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addButton))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var detailItem: NSDate? {
        didSet {
            configureView()
        }
    }

    
// MARK: - TableView cfg, uso una del estilo subtitle y la customizo on fly
//divido en dos secciones POST y COMMENTS

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Post"
        } else {
            return "Comentarios"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellDetail")
        if(indexPath.section == 0){
            cell.textLabel?.text = self.post?.title
            cell.detailTextLabel?.text = self.post?.body
            cell.textLabel?.numberOfLines = 0;
            cell.detailTextLabel?.numberOfLines = 0;
            cell.textLabel?.textColor = UIColor.blue
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        }
        else{
            cell.textLabel?.text = comments[indexPath.row].name
            cell.detailTextLabel?.text = comments[indexPath.row].body
            cell.textLabel?.numberOfLines = 0;
            cell.detailTextLabel?.numberOfLines = 0;
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 15)
            cell.textLabel?.textColor = UIColor.gray
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0 && comments.count > 0) {
            return 1
        } else {
            return comments.count
        }
    }
    
    
    
//request
    func request(){
        let parameters = ["postId": "\(postSelected)"]
        
        Alamofire.request("https://jsonplaceholder.typicode.com/comments", parameters: parameters) .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in 0..<json.count{
                    let comment = ClassComments(dictionary: json[i].dictionaryObject as! [String : AnyObject])
                    self.comments.append(comment)
                    DispatchQueue.main.async() {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
//BOTON de añadir comentario 
    func addButton(){
        let alert = UIAlertController(title: "Comenta", message: "Estas logueado como: YO", preferredStyle: .alert)
            alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in //añadimos boton de OK
            let textField = alert?.textFields![0]
            let comment = ClassComments(name: "YO", body: (textField?.text)!) //creamos el comment nuevo
            self.comments.append(comment) //lo añadimos
            self.tableview.reloadData() //recargamos vista
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { [weak alert] (_) in //añadimos cancel
            self.dismiss(animated: true, completion: nil) //quitamos pop up
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
