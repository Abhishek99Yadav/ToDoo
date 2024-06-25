//
//  ViewController.swift
//  ToDoListCoreDataAY
//
//  Created by Abhishek Yadav on 21/02/24.
//

import UIKit
import CoreData

//class ViewController: UIViewController {
//    
//    // MARK: - Properties
//    
//    lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        return tableView
//    }()
//    
//    var tasks: [Tasks] = []
//    var filteredTasks: [Tasks] = []
//    var currentFilter: String = "All"
//    
//    // MARK: - Lifecycle Methods
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        fetchTasks()
//    }
//    
//    // MARK: - Setup Methods
//    
//    private func setupViews() {
//        navigationItem.title = "Tasks"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTask))
//        navigationItem.leftBarButtonItem = editButtonItem
//        setupFilterSegmentedControl()
//        view.addSubview(tableView)
//    }
//    
//    private func setupFilterSegmentedControl() {
//        let items = ["All", "To Do", "In Progress", "Done"]
//        let segmentedControl = UISegmentedControl(items: items)
//        segmentedControl.selectedSegmentIndex = 0
//        segmentedControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
//        navigationItem.titleView = segmentedControl
//    }
//    
//    // MARK: - Actions
//    
//    @objc private func addTask() {
//        showTaskForm()
//    }
//    
//    @objc private func filterChanged(_ sender: UISegmentedControl) {
//        let filters = ["All", "To Do", "In Progress", "Done"]
//        currentFilter = filters[sender.selectedSegmentIndex]
//        filterTasks()
//    }
//    
//    private func showTaskForm(task: Tasks? = nil) {
//        let alertController = UIAlertController(title: task == nil ? "Add Task" : "Edit Task", message: nil, preferredStyle: .alert)
//        alertController.addTextField { $0.placeholder = "Enter task title"; $0.text = task?.title }
//        alertController.addTextField { $0.placeholder = "Enter task description"; $0.text = task?.taskDescription }
//        
//        let statusPicker = UIPickerView()
//        statusPicker.dataSource = self
//        statusPicker.delegate = self
//        statusPicker.tag = task == nil ? 0 : 1
//        let statusPickerView = UIView(frame: CGRect(x: 0, y: 0, width: alertController.view.frame.width, height: 150))
//        statusPickerView.addSubview(statusPicker)
//        alertController.view.addSubview(statusPickerView)
//        
//        let addAction = UIAlertAction(title: task == nil ? "Add" : "Update", style: .default) { [weak self] _ in
//            guard let title = alertController.textFields?[0].text, !title.isEmpty else { return }
//            let description = alertController.textFields?[1].text
//            let status = statusPicker.selectedRow(inComponent: 0)
//            let statusString = ["To Do", "In Progress", "Done"][status]
//            
//            if let task = task {
//                self?.updateTask(task: task, title: title, description: description, status: statusString)
//            } else {
//                self?.createTask(title: title, description: description, status: statusString)
//            }
//            
//            self?.fetchTasks()
//            self?.filterTasks()
//            self?.tableView.reloadData()
//        }
//        
//        alertController.addAction(addAction)
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        present(alertController, animated: true)
//    }
//}

// MARK: - Core Data Methods

//extension ViewController {
//    private func fetchTasks() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
//        do {
//            tasks = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
//        } catch {
//            print("Error fetching tasks: \(error.localizedDescription)")
//        }
//    }
//    
//    private func createTask(title: String, description: String?, status: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let task = Tasks(context: appDelegate.persistentContainer.viewContext)
//        task.title = title
//        task.taskDescription = description
//        task.status = status
//        appDelegate.saveContext()
//    }
//    
//    private func updateTask(task: Tasks, title: String, description: String?, status: String) {
//        task.title = title
//        task.taskDescription = description
//        task.status = status
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        appDelegate.saveContext()
//    }
//    
//    private func deleteTask(task: Tasks) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let context = appDelegate.persistentContainer.viewContext
//        context.delete(task)
//        appDelegate.saveContext()
//    }
//    
//    private func filterTasks() {
//        if currentFilter == "All" {
//            filteredTasks = tasks
//        } else {
//            filteredTasks = tasks.filter { $0.status == currentFilter }
//        }
//        tableView.reloadData()
//    }
//}

// MARK: - UITableViewDataSource

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredTasks.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
//        let task = filteredTasks[indexPath.row]
//        cell.textLabel?.text = task.title
//        cell.detailTextLabel?.text = task.taskDescription
//        cell.accessoryType = task.status == "Done" ? .checkmark : .none
//        return cell
//    }
//}

// MARK: - UITableViewDelegate

//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let task = filteredTasks[indexPath.row]
//        showTaskForm(task: task)
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let task = filteredTasks[indexPath.row]
//            deleteTask(task: task)
//            fetchTasks()
//            filterTasks()
//        }
//    }
//}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate

//extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 3 // "To Do", "In Progress", "Done"
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let statuses = ["To Do", "In Progress", "Done"]
//        return statuses[row]
//    }
//}
