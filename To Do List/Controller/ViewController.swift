//
//  ViewController.swift
//  To Do List
//
//  Created by User on 16/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var MyTextField : UITextField!
    //@IBOutlet weak var MyStatus : UILabel!
    @IBOutlet weak var MyTable: UITableView!
    var todoarray = [String]()
    override func viewDidLoad(){
        super.viewDidLoad()
        MyTable.dataSource = self
        MyTable.delegate = self
        if let data = UserDefaults.standard.object(forKey: "todolist") as? [String]{
            todoarray = data
            //MyStatus.text = "\(todoarray.count) Tasks Pending in todolist"
          //  MyStatus.text = "\(todoarray.count)"
        }
       // else{
         //   MyStatus.text = "No Tasks Pending"
       // }
    }
    @IBAction func saveButtonClick(_ sender: Any){
        if MyTextField.text != ""{
            todoarray.append(MyTextField.text!)
            UserDefaults.standard.set(todoarray, forKey: "todolist")
            MyTable.reloadData()
           // MyStatus.text = "new task added in to do list"
            MyTextField.text = ""
        }
       // else{
         //   MyStatus.text = "kindly enter task first"
        //}
    }
    
    @IBAction func clearButtonClick(_ sender: Any) {
        print("remove all")
        self.todoarray.removeAll()
        self.MyTable.reloadData()
    }
     
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoarray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoarray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.todoarray.remove(at: indexPath.row)
            self.MyTable.deleteRows(at: [indexPath], with: .automatic)
            self.MyTable.reloadData()
        }
    }
    
}

