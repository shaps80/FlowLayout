import UIKit

@available(*, deprecated, renamed: "LayoutRegion")
@objc public enum BackgroundLayoutRegion: Int {
    case none
    case outerBounds
    case innerBounds
}

public extension FlowLayoutDelegate {

    // MARK: Deprecations

    @available(*, deprecated, renamed: "collectionView(_:layout:regionForBackgroundInSection:)")
    func backgroundLayoutRegion(in collectionView: UICollectionView,
                                               forSectionAt section: Int) -> LayoutRegion { return .none }

    @available(*, deprecated, renamed: "collectionView(_:layout:insetsForBackgroundInSection:)")
    func backgroundLayoutInsets(in collectionView: UICollectionView,
                                               forSectionAt section: Int) -> UIEdgeInsets { return .zero }

}
