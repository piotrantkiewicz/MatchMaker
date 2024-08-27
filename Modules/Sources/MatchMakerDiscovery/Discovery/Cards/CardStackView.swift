import UIKit
import SnapKit

class CardStackView: UIView {
    private var cardViews: [CardView] = []
    
    var topCard: CardView? {
        cardViews.last
    }
    
    func addCard(_ card: CardView) {
        cardViews.append(card)
        addSubview(card)
        card.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func removeTopCard() {
        cardViews.removeLast()
    }
}
