//
//  ViewController.swift
//  UITableView-02
//
//  Created by Phan Dinh Van on 3/12/19.
//  Copyright © 2019 Phan Dinh Van. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var tblMessage: UITableView!
    @IBOutlet weak var txvMessageContent: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    var messages = [Message]()
    var myNumber = "1"
    var friendNumber = "2"
    @IBOutlet weak var viewMessage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMessage.delegate = self
        tblMessage.dataSource = self
        tblMessage.separatorStyle = .none
        tblMessage.estimatedRowHeight = 100
        tblMessage.rowHeight = UITableView.automaticDimension
        txvMessageContent.layer.cornerRadius = 5
        txvMessageContent.isScrollEnabled = false
        txvMessageContent.delegate = self
        txvMessageContent.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let topBoder = CALayer()
        topBoder.frame = CGRect(x: 0, y: 0, width: viewMessage.frame.size.width, height: 1)
        topBoder.backgroundColor = UIColor.groupTableViewBackground.cgColor
        viewMessage.layer.addSublayer(topBoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        messages.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 100)!, message: "Hello world 1"))
        messages.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 120)!, message: "Hello world 2"))
        messages.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 140)!, message: "Hello world 3"))
        messages.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 160)!, message: "Hello world 4"))
        messages = messages.sorted{ $0.timestamp <= $1.timestamp }
        
        tblMessage.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributedString = NSAttributedString(string: "⤒", attributes: attributes)
        btnSend.setAttributedTitle(attributedString, for: .disabled)
        
        let enableAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor(red:0.14, green:0.73, blue:0.44, alpha:1.0)]
        let attributedEnableString = NSAttributedString(string: "⤒", attributes: enableAttributes)
        btnSend.setAttributedTitle(attributedEnableString, for: .normal)
        btnSend.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: Actions
    @IBAction func btnSendAction(_ sender: Any) {
        let msg = Message(from: "1", to: "2", timestamp: Date().timeIntervalSince1970, message: txvMessageContent.text)
        messages.append(msg)
        tblMessage.reloadData()
        txvMessageContent.text = ""
        btnSend.isEnabled = false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]) as? NSValue)?.cgRectValue else {
            return
        }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func tapGesture(sender: Any) {
        view.endEditing(true)
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (messages[messages.count-indexPath.row-1].from == myNumber) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sendingcell", for: indexPath) as! sendingMessageCell
            cell.lblMessage.text = messages[messages.count-indexPath.row-1].message
            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
            //cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receivingcell", for: indexPath) as! receivingMessageCell
            cell.lblMessage.text = messages[messages.count-indexPath.row-1].message
            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
            //cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            let alert = UIAlertController(title: "Edit", message: "You are on Edit-mode", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (txtField) in
                txtField.placeholder = "Message"
                txtField.text = self.messages[self.messages.count-indexPath.row-1].message
            })
            let btnSave = UIAlertAction(title: "Save", style: .default, handler: { (action) in
                self.messages[self.messages.count-indexPath.row-1].message = alert.textFields?[0].text
                tableView.reloadRows(at: [indexPath], with: .automatic)
                handler(true)
            })
            let btnCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                handler(false)
            })
            alert.addAction(btnSave)
            alert.addAction(btnCancel)
            self.present(alert, animated: true, completion: nil)
        }
        //editAction.image = UIImage(named: "edit")
        editAction.backgroundColor = UIColor.blue
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, handler) in
            self.messages.remove(at: self.messages.count-indexPath.row-1)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            handler(true)
        }
        //deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedElement = messages[messages.count-sourceIndexPath.row-1]
        messages.remove(at: messages.count-sourceIndexPath.row-1)
        messages.insert(movedElement, at: messages.count-destinationIndexPath.row-1)
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        for view in tblMessage.subviews {
            if String(describing: type(of: view)) == "UISwipeActionPullView" {
                let deleteButton = view.subviews[0]
                let editButton = view.subviews[1]
                editButton.transform = CGAffineTransform(scaleX: 1, y: -1)
                deleteButton.transform = CGAffineTransform(scaleX: 1, y: -1)
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            btnSend.isEnabled = true
        } else {
            btnSend.isEnabled = false
        }
    }
}
