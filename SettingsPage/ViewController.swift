//
//  ViewController.swift
//  SettingsPage
//
//  Created by Кирилл on 27.01.2026.
//

import UIKit

final class ViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        setupLayout()
        setupAppearance()
        setupBehavior()
    }

    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAppearance() {
        tableView.backgroundColor = .blue
    }
    
    func setupBehavior() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: .settingsCell
        )
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        54
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: .settingsCell,
            for: indexPath
        )
        
        return cell
    }

}

private extension String {
    static let settingsCell = "SettingsCell"
}

#Preview(traits: .portrait) {
    ViewController()
}
