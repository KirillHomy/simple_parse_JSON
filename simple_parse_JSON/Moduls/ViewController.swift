//
//  ViewController.swift
//  simple_parse_JSON
//
//  Created by Kirill Khomytsevych on 15.04.2023.
//

import UIKit

class ViewController: UIViewController {

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

        rickAndMortyService.request(urlString: urlString) { [weak self] rickAndMortyModel, error in
            guard let rickAndMortyModel = rickAndMortyModel else { return }
            guard let sSelf = self else { return }
            rickAndMortyModel.results.map { name in
                print("\(name.image) ")
            }
            sSelf.rickAndMortyModel = rickAndMortyModel
        }
        setupUI()
    }

}

// MARK: - Private extension
private extension ViewController {

    func setupUI() {
        setupTableView()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RickAndMortyTableViewCell.nib(), forCellReuseIdentifier: "RickAndMortyTableViewCell")
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {

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
