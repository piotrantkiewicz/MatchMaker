import UIKit
import SnapKit
import MatchMakerCore

public class MatchesViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let viewModel: MatchesViewModel
    private let collectionView: UICollectionView
    
    init(viewModel: MatchesViewModel) {
        self.viewModel = viewModel
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMatches()
    }
    
    private func fetchMatches() {
        Task {
            do {
                try await viewModel.fetchMatches()
                collectionView.reloadData()
            } catch {
                showError(error.localizedDescription)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.text = "All Matches"
        titleLabel.font = .navigationTitle2
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(MatchCell.self, forCellWithReuseIdentifier: MatchCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
    }
}

extension MatchesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.matches.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchCell.identifier, for: indexPath) as? MatchCell else { return UICollectionViewCell() }
        
        let match = viewModel.matches[indexPath.item]
        cell.configure(with: match)
        
        return cell
    }
}

extension MatchesViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20) / 2
        return CGSize(width: width, height: width * 1.45)
    }
}











