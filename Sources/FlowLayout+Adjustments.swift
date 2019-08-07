import UIKit

extension FlowLayout {

    // MARK: - Attributes Adjustments
    
    func adjustedAttributes(for attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = collectionView,
            let adjusted = attributes as? FlowLayoutAttributes else {
                return attributes
        }

        switch adjusted.representedElementKind {
        case UICollectionView.elementKindGlobalHeader:
            adjusted.frame.origin = adjustedGlobalHeaderOrigin
            adjusted.frame.size = adjustedGlobalHeaderSize
            adjusted.zIndex = UICollectionView.globalHeaderZIndex
            
            if globalHeaderConfiguration.pinsToBounds {
                let offset = adjustedGlobalHeaderOffset
                
                if globalHeaderConfiguration.prefersFollowContent, offset.y > 0 {
                    // do nothing
                } else {
                    adjusted.frame.origin.y += offset.y
                }
                
                if globalHeaderConfiguration.pinsToContent, offset.y < 0 {
                    adjusted.frame.size.height -= offset.y
                }
            }
        case UICollectionView.elementKindGlobalFooter:
            adjusted.frame.origin = adjustedGlobalFooterOrigin
            adjusted.frame.size = adjustedGlobalFooterSize
            adjusted.zIndex = UICollectionView.globalFooterZIndex
            
            if globalFooterConfiguration.pinsToBounds {
                let offset = adjustedGlobalFooterOffset
                
                if globalFooterConfiguration.prefersFollowContent, offset.y < 0 {
                    // do nothing
                } else {
                    adjusted.frame.origin.y += offset.y
                }
                
                if globalFooterConfiguration.pinsToContent, offset.y > 0 {
                    adjusted.frame.origin.y -= offset.y
                    adjusted.frame.size.height += offset.y
                }
            }
        default:
            // make sure we adjust here so we include all other elements
            adjusted.frame.origin.y += adjustedOrigin.y

            guard adjusted.representedElementCategory == .cell else { break }

            let itemsCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: adjusted.indexPath.section) ?? 0
            adjusted.isFirstInSection = adjusted.indexPath.item == 0
            adjusted.isLastInSection = adjusted.indexPath.item == itemsCount - 1

            switch alignment(in: adjusted.indexPath.section) {
            case .left:
                guard adjusted.indexPath.item > 0 else { break }

                let previousIndexPath = IndexPath(item: adjusted.indexPath.item - 1, section: adjusted.indexPath.section)
                let previousAttributes = layoutAttributesForItem(at: previousIndexPath)!

                // if our attributes are not on the same line as the previous attributes we don't need to do anything
                guard attributes.center.y == previousAttributes.center.y else { break }

                let spacing = interitemSpacing(for: attributes.indexPath.section)
                adjusted.frame.origin.x = previousAttributes.frame.maxX + spacing
            case .none:
                break
            }
        }

        return adjusted
    }
    
    func adjustedAttributes(for attributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {
        return attributes.map { adjustedAttributes(for: $0) }
    }

    // MARK: - Content Adjustments

    var adjustedOrigin: CGPoint {
        guard cachedGlobalHeaderAttributes != nil else { return .zero }
        var origin = adjustedGlobalHeaderOrigin
        origin.y += adjustedGlobalHeaderSize.height + globalHeaderConfiguration.inset
        return origin
    }

    var additionalContentInset: CGFloat {
        guard cachedGlobalHeaderAttributes != nil, let collectionView = collectionView else { return 0 }
        guard globalHeaderConfiguration.layoutFromSafeArea else { return 0 }

        let safeAreaAdjustment = collectionView.adjustedContentInset.top - collectionView.contentInset.top

        switch collectionView.contentInsetAdjustmentBehavior {
        case .never:
            let isTopBarHidden = safeAreaAdjustment != collectionView.safeAreaInsets.top

            if isTopBarHidden {
                return collectionView.safeAreaInsets.top
            } else {
                return collectionView.adjustedContentInset.top
            }
        default:
            return safeAreaAdjustment
        }
    }

    // MARK: - Global Header Adjustments

    var adjustedGlobalHeaderOrigin: CGPoint {
        guard cachedGlobalHeaderAttributes != nil, let collectionView = collectionView else { return .zero }
        var adjustedOrigin = CGPoint.zero
        adjustedOrigin.y += additionalContentInset
        adjustedOrigin.y -= collectionView.adjustedContentInset.top
        return adjustedOrigin
    }

    var adjustedGlobalHeaderSize: CGSize {
        guard let attributes = cachedGlobalHeaderAttributes, let collectionView = collectionView else { return .zero }
        var adjustedSize = attributes.size
        adjustedSize.height += globalHeaderConfiguration.layoutFromSafeArea ? 0 : collectionView.safeAreaInsets.top
        return adjustedSize
    }

    var adjustedGlobalHeaderOffset: CGPoint {
        guard let collectionView = collectionView else { return .zero }
        var contentOffset = collectionView.contentOffset
        contentOffset.y += collectionView.adjustedContentInset.top
        return contentOffset
    }

    // MARK: - Global Footer Adjustments

    var adjustedGlobalFooterOrigin: CGPoint {
        guard let collectionView = collectionView else { return .zero }
        var adjustedOrigin = CGPoint.zero
        adjustedOrigin.y += collectionViewContentSize.height - adjustedGlobalFooterSize.height
        adjustedOrigin.y += !globalFooterConfiguration.layoutFromSafeArea ? collectionView.adjustedContentInset.bottom : 0
        return adjustedOrigin
    }

    var adjustedGlobalFooterSize: CGSize {
        guard let attributes = cachedGlobalFooterAttributes, let collectionView = collectionView else { return .zero }
        var adjustedSize = attributes.size
        adjustedSize.height += globalFooterConfiguration.layoutFromSafeArea ? 0 : collectionView.safeAreaInsets.bottom
        return adjustedSize
    }

    var adjustedGlobalFooterOffset: CGPoint {
        guard let collectionView = collectionView else { return .zero }
        var contentOffset = CGPoint(x: 0, y: collectionView.bounds.maxY - collectionViewContentSize.height)
        contentOffset.y -= collectionView.adjustedContentInset.bottom
        return contentOffset
    }

}
