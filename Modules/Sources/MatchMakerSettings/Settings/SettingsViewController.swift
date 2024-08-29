import UIKit
import SnapKit
import MatchMakerCore

public final class SettingsViewController: UIViewController {
    
    private weak var tableView: UITableView!
    private weak var logoutBtn: UIButton!
    
    public var viewModel: SettingsViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        
        viewModel.didUpdateHeader = { [weak self ] in
            self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUserProfile()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsHeaderCell.self, forCellReuseIdentifier: SettingsHeaderCell.identifier)
    }
}

extension SettingsViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupNaviationBar()
        setupTableView()
        setupLogoutBtn()
    }
    
    private func setupNaviationBar() {
        setupNavigationTitle()
        setupEditBarButton()
        setupNavigationButton()
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.font = .navigationTitle
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
    }
    
    private func setupEditBarButton() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(resource: .edit), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        rightBarButtonItem.tintColor = .accent
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupNavigationButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    @objc private func rightBarButtonTapped() {
        viewModel.presentProfileEdit()
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.tableView = tableView
        tableView.contentInset = UIEdgeInsets(top: 28, left: 0, bottom: 0, right: 0)
        tableView.isScrollEnabled = false
    }
    
    private func setupLogoutBtn() {
        let button = UIButton()
        button.titleLabel?.font = .logoutButton
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.accent.cgColor,
            UIColor.backgroundPink.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = button.bounds
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.width.equalTo(306)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-37)
        }
        
        logoutBtn = button
        
        button.layoutIfNeeded()
        gradientLayer.frame = button.bounds
    }
    
    @objc
    private func logoutButtonTapped() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
            self?.didConfirmLogout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func didConfirmLogout() {
        do {
            try viewModel.logout()
        } catch {
            showError(error.localizedDescription)
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsHeaderCell.identifier, for: indexPath) as? SettingsHeaderCell else { return UITableViewCell() }
        
        cell.configure(with: viewModel.header)
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.presentProfileEdit()
    }
}
