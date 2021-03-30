//
//  ViewController.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit

class TopicViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: TopicViewModel = {
        let viewModel = TopicViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.largeTitleDisplayMode = .always

        self.title = "Topics"
        
        tableView.tableFooterView = UIView()
        initilizeViewModel()
    }
    
    private func initilizeViewModel() {

        viewModel.showLoader = {[weak self] (_ show: Bool) in
            if show {
                self?.showLoader()
            } else {
                self?.hideLoader()
            }
        }
        
        viewModel.networkRequestHandler = {[weak self] (_ error: Error?) in
            if let _error = error {
                self?.presentAlert(title: "Error", message: _error.localizedDescription)
            } else {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchTopics()
    }
}

extension TopicViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfTopics()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopicTableViewCell.className) as? TopicTableViewCell else {
            return UITableViewCell()
        }
        let topic = viewModel.getTopic(index: indexPath.row)
        cell.setData(topic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: MeditationViewController.className) as? MeditationViewController else { return }
        controller.viewModel.topic = viewModel.getTopic(index: indexPath.row)
        controller.viewModel.subTopics = viewModel.fetchSubTopics(index: indexPath.row)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
