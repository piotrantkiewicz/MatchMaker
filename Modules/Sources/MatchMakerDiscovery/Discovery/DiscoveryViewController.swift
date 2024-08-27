import UIKit
import SDWebImage
import SnapKit
import DesignSystem

public struct User: Decodable {
    let uid: String
    let name: String
    let imageURL: URL
}

public enum SwipeDirection {
    case left
    case right
}

let mockUsers = [
    User(uid: "1", name: "Ashley", imageURL: URL(string: "https://picsum.photos/seed/ashley/584/360")!),
    User(uid: "2", name: "Emma", imageURL: URL(string: "https://picsum.photos/seed/emma/584/360")!),
    User(uid: "3", name: "Olivia", imageURL: URL(string: "https://picsum.photos/seed/olivia/584/360")!),
    User(uid: "4", name: "Sophia", imageURL: URL(string: "https://picsum.photos/seed/sophia/584/360")!),
]

public final class DiscoveryViewController: UIViewController {
    
    private let cardStackView = CardStackView()
    private let titleLabel = UILabel()
    
    private let viewModel: DiscoveryViewModel
    
    public init(viewModel: DiscoveryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGestureRecognisers()
        fetchCards()
    }
    
    private func fetchCards() {
        Task {
            do {
                try await viewModel.fetchPotentialMatches()
                didFetchMatches()
            } catch {
                showError(error.localizedDescription)
            }
        }
    }
    
    private func didFetchMatches() {
        for user in viewModel.potentialMatches {
            let cardView = CardView(user: user)
            cardStackView.addCard(cardView)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.text = "Discover"
        titleLabel.font = .navigationTitle2
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        view.addSubview(cardStackView)
        cardStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    private func setupGestureRecognisers() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        cardStackView.addGestureRecognizer(panGesture)
    }
    
    @objc
    private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let topCard = cardStackView.topCard else { return }
        
        let translation = gesture.translation(in: view)
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 180
        
        switch gesture.state {
        case .began: break
        case .changed:
            let rotationTransform = CGAffineTransform(rotationAngle: angle)
            let translationTransform = CGAffineTransform(
                translationX: translation.x,
                y: translation.y
            )
            topCard.transform = rotationTransform.concatenating(translationTransform)
        case .ended:
            handleSwipeEnd(topCard: topCard, translation: translation)
        default: break
        }
    }
    
    private func handleSwipeEnd(topCard: CardView, translation: CGPoint) {
        let swipeThreshold: CGFloat = 100
        
        if translation.x > swipeThreshold {
            swipeCard(.right)
        } else if translation.x < -swipeThreshold {
            swipeCard(.left)
        } else {
            resetCard(topCard)
        }
    }
    
    private func swipeCard(_ direction: SwipeDirection) {
        guard let topCard = cardStackView.topCard else { return }
        
        let translationX: CGFloat = direction == .right ? 300 : -300
        
        UIView.animate(withDuration: 0.3) {
            topCard.center = CGPoint(x: topCard.center.x + translationX, y: topCard.center.y)
            topCard.alpha = 0
        } completion: { _ in
            self.cardStackView.removeTopCard()
        }

    }
    
    private func resetCard(_ card: CardView) {
        UIView.animate(withDuration: 0.2) {
            card.transform = .identity
        }
    }
}











