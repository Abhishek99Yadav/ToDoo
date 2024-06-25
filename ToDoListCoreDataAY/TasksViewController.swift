//
//  TasksViewController.swift
//  ToDoListCoreDataAY
//
//  Created by Abhishek Yadav on 26/06/24.
//

import UIKit
import CoreData

class TasksViewController: UIViewController {

    // MARK: - Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var tasks: [Task] = []
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchTasks()
    }
    
    // MARK: - Setup Methods
    
    private func setupViews() {
        navigationItem.title = "ToDooo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTask))
        view.addSubview(tableView)
    }
    
    // MARK: - Actions
    
    @objc private func addTask() {
        let taskFormViewController = TaskFormViewController()
        taskFormViewController.delegate = self
        navigationController?.pushViewController(taskFormViewController, animated: true)
    }
    
    // MARK: - Core Data Methods
    
    private func fetchTasks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            tasks = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching tasks: \(error.localizedDescription)")
        }
    }
    
    private func createTask(title: String, description: String, status: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let task = Task(context: appDelegate.persistentContainer.viewContext)
        task.title = title
        task.taskDescription = description
        task.status = status
        appDelegate.saveContext()
    }
    
    private func updateTask(task: Task) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
    
    private func deleteTask(task: Task) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(task)
        appDelegate.saveContext()
    }
}

// MARK: - UITableViewDataSource

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.accessoryType = task.completed ? .checkmark : .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        task.completed.toggle()
        updateTask(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            deleteTask(task: task)
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - TaskFormViewControllerDelegate

extension TasksViewController: TaskFormViewControllerDelegate {
    func taskFormViewController(_ controller: TaskFormViewController, didSaveTaskWithTitle title: String, description: String, status: String) {
        createTask(title: title, description: description, status: status)
        fetchTasks()
        tableView.reloadData()
    }
}
