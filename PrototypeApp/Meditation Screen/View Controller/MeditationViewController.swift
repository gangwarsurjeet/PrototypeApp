//
//  MeditationViewController.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit

class MeditationViewController: BaseViewController {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: MeditationViewModel = {
        let viewModel = MeditationViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.largeTitleDisplayMode = .always

        self.title = viewModel.topic?.title
        self.descLabel.text = viewModel.topic?.description

        tableView.register(UINib(nibName: MeditationTableHeaderView.className, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: MeditationTableHeaderView.className)
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
        viewModel.fetchMedications()
    }
}

extension MeditationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSection()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeader(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MeditationTableHeaderView.className) as? MeditationTableHeaderView {
            headerView.titleLabel.text = viewModel.headerTitle(section: section)
            return headerView
        }
        return nil
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfMedication(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeditationTableViewCell.className) as? MeditationTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(viewModel.getMedication(indexPath: indexPath))
        return cell
    }
    
}
