//
//  ServicesTableCell.swift
//  Services
//
//  Created by Margo Naumenko on 13.07.2022.
//

import UIKit

class ServicesTableCell: UITableViewCell {
    static let identifier = "ServicesTableCell"
    
    let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Arial", size: 18)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 3
        label.font = UIFont(name: "Arial", size: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 10, y: 8, width: size, height: size)
        let imageSize: CGFloat = size / 1.5
        iconImageView.frame = CGRect(x: (size - imageSize)/2,
                                     y: (size - imageSize)/2,
                                     width: imageSize,
                                     height: imageSize)
        titleLabel.frame = CGRect(x: 15 + iconContainer.frame.size.width,
                             y: -15,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
        descriptionLabel.frame = CGRect(x: 15 + iconContainer.frame.size.width,
                                        y: 10,
                                        width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                                        height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
        iconContainer.backgroundColor = nil
    }
    
    func configure(with model: Service){
        titleLabel.text = model.name
        descriptionLabel.text = model.description
        if let loadedIcon = UIImage(url: URL(string: model.icon_url)) {
            iconImageView.image =  loadedIcon
        } else {
            iconImageView.image = UIImage(systemName: "xmark.octagon")
        }
        
    }

    
}
