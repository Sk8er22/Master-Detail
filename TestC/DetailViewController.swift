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
    
    //definimos variables
    var postSelected: Int = 0
    var comments = [ClassComments]()
    var post: ClassPosts?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 40
        self.tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addButton))
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.request()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1).withAlphaComponent(0.5)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellComments", for: indexPath) as! CellPosts
        if(indexPath.section == 0){
            cell.titlePosts?.text = self.post?.title
            cell.titlePosts?.textAlignment = NSTextAlignment.left
            cell.titlePosts?.numberOfLines = 0;
            cell.titlePosts?.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            cell.titlePosts?.font = UIFont.boldSystemFont(ofSize: 20.0)
            cell.bodyPosts?.numberOfLines = 0;
            cell.bodyPosts?.text = self.post?.body
        }
        else{
            cell.titlePosts?.text = "by: " + comments[indexPath.row].name
            cell.titlePosts?.numberOfLines = 0;
            cell.titlePosts?.textAlignment = NSTextAlignment.right
            cell.titlePosts?.font = UIFont.italicSystemFont(ofSize: 15)
            cell.titlePosts?.textColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            cell.bodyPosts?.numberOfLines = 0;
            cell.bodyPosts?.text = comments[indexPath.row].body
            cell.bodyPosts?.sizeToFit()
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell:
        UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationAngleInRadians = 360.0 * CGFloat(M_PI/360.0)
        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, -500, 100, 0)
        _ = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.3, animations: {cell.layer.transform = CATransform3DIdentity})
    }
    
    //Detail
    var detailItem: NSDate? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if detailItem != nil {
            if (detailDescriptionLabel) != nil {
                self.request()
            }
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
                    let comment = ClassComments(dictionary: json[i].dictionaryObject! as [String : AnyObject])
                    self.comments.append(comment)
                }
                DispatchQueue.main.async() {
                    self.tableView.setNeedsLayout()
                    self.tableView.layoutIfNeeded()
                    self.tableView.reloadData()
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
