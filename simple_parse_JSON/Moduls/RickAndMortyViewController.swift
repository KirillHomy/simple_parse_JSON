//
//  ViewController.swift
//  simple_parse_JSON
//
//  Created by Kirill Khomytsevych on 15.04.2023.
//

import UIKit

final class RickAndMortyViewController: UIViewController {

    // MARK: - Private constant
    private let urlString = "https://rickandmortyapi.com/api/character"
    private let rickAndMortyService = RickAndMortyService()

    // MARK: - Private variables
    private var rickAndMortyModel: RickAndMortyModel? = nil

    // MARK: - Private IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

// MARK: - Private extension
private extension RickAndMortyViewController {

    func setupUI() {
        setupRequest()
        setupTableView()
        setupNavigationController()
    }

    func setupRequest() {
        rickAndMortyService.request(urlString: urlString) { [weak self] rickAndMortyModel, error in
            guard let rickAndMortyModel = rickAndMortyModel else { return }
            guard let sSelf = self else { return }
            // Show all image
//            rickAndMortyModel.results.map { name in
//                print(name.image)
//            }
            sSelf.rickAndMortyModel = rickAndMortyModel
        }
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RickAndMortyTableViewCell.nib(), forCellReuseIdentifier: "RickAndMortyTableViewCell")
    }

    func setupNavigationController() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.isOpaque = true
        navigationItem.title = "Rick and Morty"
        navigationItem.backButtonTitle = ""
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RickAndMortyViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rickAndMortyModel = rickAndMortyModel else { return 0 }
        return rickAndMortyModel.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RickAndMortyTableViewCell", for: indexPath) as? RickAndMortyTableViewCell else { return UITableViewCell() }

        guard let rickAndMortyModel = rickAndMortyModel else { return UITableViewCell() }
        cell.configurCell(model: rickAndMortyModel, index: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

}
