import UIKit

@objc public protocol FlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
    
    /// Returns the height for the global header. Return 0 to hide the global header
    @objc optional func heightForGlobalHeader(in collectionView: UICollectionView,
                                              layout collectionViewLayout: UICollectionViewLayout) -> CGFloat
    
    /// Returns the height for the global header. Return 0 to hide the global header
    @objc optional func heightForGlobalFooter(in collectionView: UICollectionView,
                                              layout collectionViewLayout: UICollectionViewLayout) -> CGFloat

    /// Returns the background style to apply for the specified section. Returning `.none` to indicate no background should be used.
    ///
    /// If you do not implement this method, the layout will not provide a section background. Your implementation of this method can return a fixed background or return different backgrounds  for each section.
    /// If you return a `region` other than `.none` you must provide a view via your `collectionView(_:viewForSupplementaryElementOfKind:at:)` method
    ///
    /// - Parameters:
    ///   - collectionView: The collection view object displaying the layout
    ///   - layout: The layout object requesting the information
    ///   - section: The index number of the section whose region is needed
    /// - Returns: The region to be used for laying out the section background. Return .none for no background.
    @objc optional func collectionView(_ collectionView: UICollectionView,
                                       layout: UICollectionViewLayout,
                                       regionForBackgroundInSection section: Int) -> LayoutRegion

    /// Returns insets that will be used to layout the background view.
    ///
    /// Background insets are margins applied only to the background in the section. They do not affect the size of the header, footer or cells themselves.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view object displaying the layout
    ///   - layout: The layout object requesting the information
    ///   - section: The index number of the section whose insets are needed
    /// - Returns: The margins to apply to the background in the section
    @objc optional func collectionView(_ collectionView: UICollectionView,
                                       layout: UICollectionViewLayout,
                                       insetsForBackgroundInSection section: Int) -> UIEdgeInsets

    // MARK: Deprecations

    @available(*, deprecated, renamed: "collectionView(_:layout:regionForBackgroundInSection:)")
    @objc optional func backgroundLayoutRegion(in collectionView: UICollectionView,
                                forSectionAt section: Int) -> LayoutRegion

    @available(*, deprecated, renamed: "collectionView(_:layout:insetsForBackgroundInSection:)")
    @objc optional func backgroundLayoutInsets(in collectionView: UICollectionView,
                                forSectionAt section: Int) -> UIEdgeInsets
    
}
