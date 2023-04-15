//
//  RickAndMortyTableViewCell.swift
//  simple_parse_JSON
//
//  Created by Kirill Khomytsevych on 15.04.2023.
//

import UIKit

class RickAndMortyTableViewCell: UITableViewCell {

    // MARK: - Private IBOutlet
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet private weak var characterTitle: UILabel!

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    // MARK: - Internal Method
    static func nib() -> UINib {
        UINib(nibName: "RickAndMortyTableViewCell", bundle: nil)
    }

    func configurCell(model: RickAndMortyModel, index: IndexPath) {
        if let imageURL = URL(string: model.results[index.row].image) {
            let task = URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                guard let data = data else {
                    print("No image data returned")
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.characterImage.image = image
                }
            }
            task.resume()
        }
        characterTitle.text = model.results[index.row].name
    }

}

// MARK: - Private extension
private extension RickAndMortyTableViewCell {

    func setupUI() {
        setupMainView()
        setupCharacterImage()
        setupCharacterTitle()
    }

    func setupMainView() {
        mainView.layer.cornerRadius = 15
        mainView.backgroundColor = .gray
    }

    func setupCharacterImage() {
        characterImage.layer.cornerRadius = 5
    }

    func setupCharacterTitle() {
        characterTitle.textColor = .label
        characterTitle.font = .boldSystemFont(ofSize: 15)
    }

}
