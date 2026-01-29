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

extension UITableView {
    
    func setup(header: UIView) {
        header.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView = header
        header.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func updateHeaderLayout() {
        guard let tableHeader = tableHeaderView else { return }
        
        tableHeader.setNeedsLayout()
        tableHeader.layoutIfNeeded()
    }
    
}

final class ViewController: UITableViewController {
    
    private let tableViewHeader = ProfileHeaderView(frame: .zero)
    
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

        tableViewHeader.configure(
            with: UIImage(named: "profile_icon"),
            name: "Кирилл Чернов",
            email: "kurillccc@icloud.com"
        )

        tableView.setup(header: tableViewHeader)
        tableView.updateHeaderLayout()
                
        tableView.reloadData()
        
        applyBackgroundForCurrentTrait()
        
        tableView.register(
            SettingsTableViewCell.self,
            forCellReuseIdentifier: SettingsTableViewCell.identifier
        )
    }
    
    private func applyBackgroundForCurrentTrait() {
        let imageName = (traitCollection.userInterfaceStyle == .dark)
              ? "background_settings_dark"
              : "background_settings_light"
        tableView.backgroundView = UIImageView(image: UIImage(named: imageName))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else { return }
        applyBackgroundForCurrentTrait()
        
        tableView.visibleCells.forEach { cell in
            if let cell = cell as? SettingsTableViewCell,
               let indexPath = tableView.indexPath(for: cell) {
                let model = sections[indexPath.section].cells[indexPath.row]
                if model.title == "Dark Mode" {
                    cell.configure(with: model, isOn: (traitCollection.userInterfaceStyle == .dark))
                } else {
                    cell.configure(with: model)
                }
            }
        }
    }

}

// MARK: - UITableViewDelegate

extension ViewController {
    
}

// MARK: - UITableViewDataSource

extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        sections[section].cells.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        sections[section].title
    }

    override func tableView(
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
        
        if model.showToggle {
            if model.title == "Dark Mode" {
                cell.configure(with: model, isOn: (traitCollection.userInterfaceStyle == .dark))
                cell.onToggleChanged = { [weak self] isOn in
                    guard let self = self else { return }
                    self.overrideUserInterfaceStyle = isOn ? .dark : .light
                    self.applyBackgroundForCurrentTrait()
                }
            } else {
                cell.configure(with: model)
                cell.onToggleChanged = nil
            }
        } else {
            cell.configure(with: model)
            cell.onToggleChanged = nil
        }
        
        cell.backgroundColor = .clear
        
        return cell
    }

}

// MARK: - Setup Images

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
