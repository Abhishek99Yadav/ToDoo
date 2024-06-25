//
//  DescriptionViewController.swift
//  ToDoListCoreDataAY
//
//  Created by Abhishek Yadav on 26/06/24.
//

import UIKit
import CoreData

class DescriptionViewController: UIViewController {
    
    let task: Task
    
    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = task.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = task.taskDescription
        descriptionLabel.numberOfLines = 0
        
        let statusLabel = UILabel()
        statusLabel.text = "Status: \(task.status ?? "")"
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, statusLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}




