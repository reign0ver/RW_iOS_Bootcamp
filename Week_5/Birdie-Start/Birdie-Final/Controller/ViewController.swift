//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupImagePicker()
        MediaPostsHandler.shared.getPosts()
    }

    private func setUpTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.allowsSelection = false
        
        tableview.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
        tableview.register(UINib(nibName: "PostImageCell", bundle: nil), forCellReuseIdentifier: "postImageCell")
    }
    
    private func setupImagePicker () {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        sendTextPost()
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func sendTextPost () {
        let alert = UIAlertController(title: "New Post", message: "What's on your mind?", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Username"
        }
        alert.addTextField { textField in
            textField.placeholder = "Tweet"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            guard let strongSelf = self else { return }
            guard let textField = alert.textFields  else { return }
            if textField[0].text != "" && textField[1].text != "" {
                let userName = textField[0].text!
                let tweet = textField[1].text!
                let textPost = TextPost(textBody: tweet, userName: userName, timestamp: Date())
                MediaPostsHandler.shared.addTextPost(textPost: textPost)
                strongSelf.tableview.reloadData()
            } else {
                let alert = UIAlertController(title: "Ups", message: "Please fill all the fields", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                strongSelf.present(alert, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func sendImagePost (_ image: UIImage) {
        let alert = UIAlertController(title: "New Post", message: "What's on your mind?", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Username"
        }
        alert.addTextField { textField in
            textField.placeholder = "Tweet"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            guard let strongSelf = self else { return }
            guard let textField = alert.textFields  else { return }
            if textField[0].text != "" && textField[1].text != "" {
                let userName = textField[0].text!
                let tweet = textField[1].text!
                let imagePost = ImagePost(textBody: tweet, userName: userName, timestamp: Date(), image: image)
                MediaPostsHandler.shared.addImagePost(imagePost: imagePost)
                strongSelf.tableview.reloadData()
            } else {
                let alert = UIAlertController(title: "Ups", message: "Please fill all the fields", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                strongSelf.present(alert, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}


//MARK: - TableView DataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaPostsHandler.shared.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentPost = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        
        if currentPost is TextPost {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
            cell.configureCell(currentPost as! TextPost)
            return cell
        } else if currentPost is ImagePost {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postImageCell", for: indexPath) as! PostImageCell
            cell.configureCell(currentPost as! ImagePost)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - TableView Delegate

extension ViewController: UITableViewDelegate { }


//MARK: - ImagePicker Delegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else { return }
        sendImagePost(image)
    }
}



