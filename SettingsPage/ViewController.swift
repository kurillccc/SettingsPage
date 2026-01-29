//
//  ViewController.swift
//  SettingsPage
//
//  Created by Кирилл on 27.01.2026.
//

import UIKit

struct SettingsModel {
    let iconName: UIImage
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
                iconName: .customHeart,
                title: "Wishlist",
                showToggle: false
            ),
            SettingsModel(
                iconName: .customDownload,
                title: "Download",
                showToggle: false
            )
        ]),
        SettingsSectionModel(title: "Preferences", cells: [
            SettingsModel(
                iconName: .customMoon,
                title: "Dark Mode",
                showToggle: true
            ),
            SettingsModel(
                iconName: .customPlanet,
                title: "Language",
                showToggle: false
            )
        ]),
        SettingsSectionModel(title: "Account", cells: [
            SettingsModel(
                iconName: .customLogout,
                title: "Logout",
                showToggle: false
            ),
            SettingsModel(
                iconName: .customShield,
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
            SettingsTableViewCell.self,
            forCellReuseIdentifier: SettingsTableViewCell.identifier
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsTableViewCell.identifier,
            for: indexPath
        ) as? SettingsTableViewCell else {
            assertionFailure("Unable to dequeue SettingsTableViewCell")
            return UITableViewCell()
        }
        
        let section = sections[indexPath.section]
        let model = section.cells[indexPath.row]
        
        cell.configure(with: model)
        cell.backgroundColor = .clear
        
        return cell
    }

}

extension UIImage {
    
    static var customMoon: UIImage {
        UIImage(named: "moon_settings")!
    }
    
    static var customDownload: UIImage {
        UIImage(named: "download_settings")!
    }
    
    static var customHeart: UIImage {
        UIImage(named: "heart_settings")!
    }
    
    static var customLogout: UIImage {
        UIImage(named: "logout_settings")!
    }
    
    static var customPlanet: UIImage {
        UIImage(named: "planet_settings")!
    }
    
    static var customShield: UIImage {
        UIImage(named: "shield_settings")!
    }
}

#Preview(traits: .portrait) {
    ViewController()
}
