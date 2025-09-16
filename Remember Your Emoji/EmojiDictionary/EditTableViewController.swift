//
//  EditTableViewController.swift
//  EmojiDictionary
//
//  Created by Hemant Sardana on 07/09/25.
//

import UIKit

class EditTableViewController: UITableViewController {
    
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var emoji: Emoji?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        
        if let emoji = emoji {
            updateUI(emoji: emoji)
        }
        updateTheButtonState()
        
    }
    
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(emoji: Emoji) {
        symbolTextField.text = emoji.symbol
        nameTextField.text = emoji.name
        usageTextField.text = emoji.usage
        descriptionTextField.text = emoji.description
    }
    
    
    
    @IBAction func textFieldUpdated(_ sender: Any) {
        updateTheButtonState()
        
    }
    func updateTheButtonState() {
        guard symbolTextField.text != "" && nameTextField.text != "" && descriptionTextField.text != "" && usageTextField.text != "" else {
            saveButton.isEnabled = false
            return
        }
        saveButton.isEnabled = true
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let emoji = Emoji(symbol: symbolTextField.text ?? "", name: nameTextField.text ?? "", description: descriptionTextField.text ?? "", usage: usageTextField.text ?? "")
        self.emoji = emoji
        performSegue(withIdentifier: "saveSegue", sender: nil)
    }
    
    
}
