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
        
        messages.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 100)!, message: "Hello world 1"))
        messages.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 120)!, message: "Hello world 2"))
        messages.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 140)!, message: "Hello world 3"))
        messages.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 160)!, message: "Hello world 4"))
        
        tblMessage.transform = CGAffineTransform(scaleX: 1, y: -1)
        tblMessage.isEditing = true
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributedString = NSAttributedString(string: "⤒", attributes: attributes)
        btnSend.setAttributedTitle(attributedString, for: .disabled)
        
        let enableAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor(red:0.14, green:0.73, blue:0.44, alpha:1.0)]
        let attributedEnableString = NSAttributedString(string: "⤒", attributes: enableAttributes)
        btnSend.setAttributedTitle(attributedEnableString, for: .normal)
        btnSend.isEnabled = false
        
    }
    
    //MARK: Actions
    @IBAction func btnSendAction(_ sender: Any) {
        let msg = Message(from: "1", to: "2", timestamp: Date().timeIntervalSince1970, message: txvMessageContent.text)
        messages.append(msg)
        tblMessage.reloadData()
        txvMessageContent.text = ""
        btnSend.isEnabled = false
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
        let sortedMessages = messages.sorted{ $0.timestamp > $1.timestamp }
        if (sortedMessages[indexPath.row].from == myNumber) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sendingcell", for: indexPath) as! sendingMessageCell
            cell.lblMessage.text = sortedMessages[indexPath.row].message
            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receivingcell", for: indexPath) as! receivingMessageCell
            cell.lblMessage.text = sortedMessages[indexPath.row].message
            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let movedElement = tableView.cellForRow(at: sourceIndexPath)
//    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            btnSend.isEnabled = true
        } else {
            btnSend.isEnabled = false
        }
    }
}
