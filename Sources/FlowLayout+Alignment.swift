import UIKit

internal extension FlowLayout {

    // Returns attributes for an aligned element
    func applyAlignment(_ alignment: LayoutAlignment, for attributes: FlowLayoutAttributes) {
        switch alignment {
        case .left:
            guard attributes.indexPath.item > 0 else { return }

            let previousIndexPath = IndexPath(item: attributes.indexPath.item - 1, section: attributes.indexPath.section)
            let previousAttributes = layoutAttributesForItem(at: previousIndexPath)!

            // if our attributes are not on the same line as the previous attributes we don't need to do anything
            guard attributes.center.y == previousAttributes.center.y else { return }

            // swiftlint:disable:next force_cast
            let spacing = interitemSpacing(for: attributes.indexPath.section)
            attributes.frame.origin.x = previousAttributes.frame.maxX + spacing
//        case .trailing:
//        case .justified:
        case .none:
            break
        }
    }

}
