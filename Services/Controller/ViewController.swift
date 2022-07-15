//
//  ViewController.swift
//  Services
//
//  Created by Margo Naumenko on 13.07.2022.
//

import UIKit
import WebKit
import SafariServices


struct Section {
    let title: String
    let services: [Service]
}



class ViewController: UIViewController {
    
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ServicesTableCell.self, forCellReuseIdentifier: ServicesTableCell.identifier)
        return table
    }()
    
    
    var models = [Service]()
    
    var serviceManager = ServiceManager()

    
    override func viewWillAppear(_ animated: Bool) {
        serviceManager.fetchServices()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        serviceManager.delegate = self
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let url = URL(string: models[indexPath.row].link) {

            if UIApplication.shared.canOpenURL(url)
            {
                UIApplication.shared.open(url)
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Не удалось открыть информацию о сервисе", preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }

        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let settingsOption = models[indexPath.row]
        guard  let cell = tableView.dequeueReusableCell(
            withIdentifier: ServicesTableCell.identifier,
            for: indexPath
        ) as? ServicesTableCell else {
                return UITableViewCell()
            }
        cell.configure(with: settingsOption)
        return cell
    }
}

extension ViewController: ServiceManagerDelegate{
    func didLoadServices(services: [Service]) {
        models = services
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить список сервисов", preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
