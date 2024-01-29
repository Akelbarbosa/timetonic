//
//  BookCell.swift
//  Timetonic
//
//  Created by Akel Barbosa on 29/01/24.
//

import UIKit
import SDWebImage

class BookCell: UITableViewCell {
    static let identifer = "BookCell"
    
    //MARK: - Views
    private let containerView: UIView = {
        let image = UIView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let imageBookImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleBookLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Configure Views
    private func configureViews() {
        //Container
        contentView.addSubview(containerView)
               
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
        containerView.layer.masksToBounds = false

        //Image
        containerView.addSubview(imageBookImage)
        imageBookImage.contentMode = .scaleAspectFit
        imageBookImage.layer.cornerRadius = 10
        imageBookImage.clipsToBounds = true
        imageBookImage.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            imageBookImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            imageBookImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            imageBookImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            imageBookImage.heightAnchor.constraint(equalToConstant: 100),
            imageBookImage.widthAnchor.constraint(equalToConstant: 100),

            
        ])
        
        //TItle Label
        containerView.addSubview(titleBookLabel)
        titleBookLabel.numberOfLines = 0
        titleBookLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        NSLayoutConstraint.activate([
            titleBookLabel.centerYAnchor.constraint(equalTo: imageBookImage.centerYAnchor),
            titleBookLabel.leadingAnchor.constraint(equalTo: imageBookImage.trailingAnchor, constant: 10),
            titleBookLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
        
        ])
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    private func configureImageViewFromUrlString(url: String) {
        guard let url = URL(string: url) else { return }
        imageBookImage.sd_setImage(with: url)
    }
    
    
    
    //MARK: - Configure Cell
    func configureCell(book: ListBookEntity) {
        configureImageViewFromUrlString(url: book.imageUrl)
        titleBookLabel.text = book.title
    }
    
}
