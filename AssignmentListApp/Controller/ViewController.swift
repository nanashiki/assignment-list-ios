//
//  ViewController.swift
//  AssignmentListApp
//
//  Created by nanashiki on 2019/05/25.
//  Copyright © 2019 nanashiki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var list = [Assignment]()
    var saveButton: UIAlertAction?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "課題の追加",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "キャンセル",
            style: .cancel,
            handler: nil)
        )
        
        let saveButton = UIAlertAction(
            title: "保存",
            style: .default) { [weak self] action in
                guard let weakSelf = self else {
                    return
                }
                
                if let title = alert.textFields?.first?.text {
                    weakSelf.list += [Assignment(title: title)]
                    weakSelf.tableView.insertRows(at: [IndexPath(row: weakSelf.list.count - 1, section: 0)], with: .automatic)
                }
        }
        saveButton.isEnabled = false
        
        alert.addAction(saveButton)
        
        self.saveButton = saveButton
        
        alert.addTextField()
        
        if let tf = alert.textFields?.first {
            tf.delegate = self
        }
        
        present(alert, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].title
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "完了しますか？",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "キャンセル",
            style: .cancel,
            handler: nil)
        )
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default) { [weak self] action in
                guard let weakSelf = self else {
                    return
                }
                
                weakSelf.tableView.deselectRow(at: indexPath, animated: true)
                weakSelf.list.remove(at: indexPath.row)
                weakSelf.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        )
        
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = (textField.text ?? "").mutableCopy() as? NSMutableString {
            text.replaceCharacters(in: range, with: string)
            saveButton?.isEnabled = text.length != 0
        }
        
        return true
    }
}
