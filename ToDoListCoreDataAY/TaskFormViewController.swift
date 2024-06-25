//
//  TaskFormViewController.swift
//  ToDoListCoreDataAY
//
//  Created by Abhishek Yadav on 26/06/24.
//

import UIKit

protocol TaskFormViewControllerDelegate: AnyObject {
    func taskFormViewController(_ controller: TaskFormViewController, didSaveTaskWithTitle title: String, description: String, status: String)
}

class TaskFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    weak var delegate: TaskFormViewControllerDelegate?
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        return textField
    }()
    
    private let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        return textField
    }()
    
    private let statusPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let statusOptions = ["To Do", "In Progress", "Done"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTask))
        setupViews()
        
        statusPicker.delegate = self
        statusPicker.dataSource = self
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, descriptionTextField, statusPicker])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func saveTask() {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextField.text else {
            let alert = UIAlertController(title: "Error", message: "Title is required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let selectedStatusIndex = statusPicker.selectedRow(inComponent: 0)
        let status = statusOptions[selectedStatusIndex]
        
        delegate?.taskFormViewController(self, didSaveTaskWithTitle: title, description: description, status: status)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusOptions.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusOptions[row]
    }
}
