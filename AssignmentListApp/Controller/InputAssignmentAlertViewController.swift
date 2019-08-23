//
//  InputAssignmentAlertViewController.swift
//  AssignmentListApp
//
//  Created by nanashiki on 2019/07/08.
//  Copyright © 2019 nanashiki. All rights reserved.
//

import UIKit

class InputAssignmentAlertViewController: UIAlertController {
    var saveButton: UIAlertAction?
    
    func setup(saveCallBack: @escaping (String) -> ()) {
        addAction(UIAlertAction(
            title: "キャンセル",
            style: .cancel,
            handler: nil)
        )
        
        let saveButton = UIAlertAction(
            title: "保存",
            style: .default) { [weak self] action in
                if let title = self?.textFields?.first?.text {
                    saveCallBack(title)
                }
        }
        saveButton.isEnabled = false
        
        addAction(saveButton)

        self.saveButton = saveButton

        addTextField {
            $0.placeholder = "タイトル"
            $0.delegate = self
        }
    }
}

extension InputAssignmentAlertViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = (textField.text ?? "").mutableCopy() as? NSMutableString {
            text.replaceCharacters(in: range, with: string)
            saveButton?.isEnabled = text.length != 0
        }
        
        return true
    }
}
