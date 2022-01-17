//
//  ViewController.swift
//  sample-github
//
//  Created by KaitoKudo on 2022/01/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var repositories = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRepositories()
        tableView.dataSource = self
    }
    
    func fetchRepositories() {
        let requestUrl = "https://api.github.com/search/repositories?q=Swift"
        let task = URLSession.shared.dataTask(with: URL(string: requestUrl)!) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            do {
                let repositories = try JSONDecoder().decode(GitHubResponse.self, from: data)
                self?.repositories = repositories.items
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
            
        }
        task.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = repositories[indexPath.row].fullName
        return cell
    }
}
