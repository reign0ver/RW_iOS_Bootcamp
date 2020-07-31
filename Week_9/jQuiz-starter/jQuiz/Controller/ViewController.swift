//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!

    var options: [String]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var correctAnswerClue: Clue? {
        willSet {
            if let newValue = newValue {
                print(newValue)
                self.correctAnswerClue = newValue
            }
        }
    }
    var points: Int = 0
    
    private let cellId = String(describing: TableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        self.scoreLabel.text = "\(self.points)"

        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }

        SoundManager.shared.playSound()
        setupHeaderImage()
        setupView()
    }

    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }
    
    @IBAction func restartGame(_ sender: Any) {
        setupView()
        points = 0
        scoreLabel.text = "\(self.points)"
    }
    
    private func setupHeaderImage() {
        Networking.sharedInstance.getHeaderImage { data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.logoImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func setupView() {
        Networking.sharedInstance.getARandomCategory { clue in
            self.correctAnswerClue = clue
            DispatchQueue.main.async {
                self.categoryLabel.text = clue.category.title
                self.clueLabel.text = clue.question
                Networking.sharedInstance.getOptions(clue.categoryId) { options in
                    self.options = options
                    self.options?.append(clue.answer)
                }
            }
        }
    }
    
    private func nextRound(_ currentCell: UITableViewCell, _ isCorrect: Bool) {
        updateCell(cell: currentCell, isCorrect)
        setupView()
        points += isCorrect ? 100 : 0
        scoreLabel.text = "\(self.points)"
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! TableViewCell
        cell.answerLabel.text = options?[indexPath.section]
        cell.contentView.layer.cornerRadius = 6
        cell.contentView.layer.borderWidth = 0.8
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.backgroundColor = .lightGray
        cell.backgroundColor = .systemPurple
        cell.answerLabel.textAlignment = .center
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! TableViewCell
        let isCorrect = correctAnswerClue?.answer == options?[indexPath.section]
        nextRound(currentCell, isCorrect)
    }
    
    private func updateCell(cell: UITableViewCell, _ isCorrect: Bool) {
        if isCorrect {
            cell.contentView.layer.borderColor = UIColor.green.cgColor
            cell.contentView.backgroundColor = .systemGreen
        } else {
            cell.contentView.layer.borderColor = UIColor.red.cgColor
            cell.contentView.backgroundColor = .systemRed
        }
    }
}

