//
//  ViewController.swift
//  SettingsPage
//
//  Created by Кирилл on 27.01.2026.
//

import UIKit

struct SettingsModel {
    let iconName: String
    let title: String
    let showToggle: Bool
}

struct SettingsSectionModel {
    let title: String
    let cells: [SettingsModel]
}

final class ViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let sections: [SettingsSectionModel] = [
        SettingsSectionModel(title: "Media", cells: [
            SettingsModel(
                iconName: ".customHeart",
                title: "Wishlist",
                showToggle: false
            ),
            SettingsModel(
                iconName: ".customDownload",
                title: "Download",
                showToggle: false
            )
        ]),
        SettingsSectionModel(title: "Preferences", cells: [
            SettingsModel(
                iconName: ".customMoon",
                title: "Dark Mode",
                showToggle: true
            ),
            SettingsModel(
                iconName: ".customPlanet",
                title: "Language",
                showToggle: false
            )
        ]),
        SettingsSectionModel(title: "Account", cells: [
            SettingsModel(
                iconName: ".customLogout",
                title: "Logout",
                showToggle: false
            ),
            SettingsModel(
                iconName: ".customShield",
                title: "Privacy",
                showToggle: true
            )
        ])
    ]
    
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
        tableView.backgroundView = UIImageView(image: UIImage(named: "background_settings_light"))
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        sections[section].cells.count
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        sections[section].title
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: .settingsCell,
            for: indexPath
        )
        
        let section = sections[indexPath.section]
        let item = section.cells[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        return cell
    }

}

private extension String {
    static let settingsCell = "SettingsCell"
}

#Preview(traits: .portrait) {
    ViewController()
}
