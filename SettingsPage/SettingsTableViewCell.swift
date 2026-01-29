//
//  SettingsViewCell.swift
//  SettingsPage
//
//  Created by Кирилл on 29.01.2026.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let toggleSwitch = UISwitch()
    
    var onToggleChanged: ((Bool) -> Void)?
    
    static let identifier = "SettingsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [
            iconImageView,
            titleLabel,
            arrowImageView,
            toggleSwitch
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24),
            
            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            toggleSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        contentView.backgroundColor = .clear
                
        toggleSwitch.isHidden = true
        toggleSwitch.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
                
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .tertiaryLabel
        
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = .label
        
        arrowImageView.image = UIImage(named: "arrow_settings")
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .tertiaryLabel
        arrowImageView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        titleLabel.text = nil
        arrowImageView.isHidden = false
        toggleSwitch.isHidden = true
        toggleSwitch.isOn = false
        onToggleChanged = nil
    }
    
    func configure(with model: SettingsModel, isOn: Bool? = nil) {
        iconImageView.image = model.iconName
        titleLabel.text = model.title
        
        arrowImageView.isHidden = model.showToggle
        toggleSwitch.isHidden = model.showToggle == false
        
        if model.showToggle {
            if let isOn = isOn {
                toggleSwitch.isOn = isOn
            }
        }
    }
    
    @objc private func toggleChanged(_ sender: UISwitch) {
        onToggleChanged?(sender.isOn)
    }
    
}
