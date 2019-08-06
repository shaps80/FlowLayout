# FlowLayout

A high-performance flow layout that provides global headers, footers, section backgrounds and various configurations.

Checkout <a href="https://github.com/shaps80/FlowLayout-Demo">FlowLayoutDemo</a> for a Demo project.

## Changelog

### Release 2.0.0

> Notes: `FlowLayoutDelegate` has completely new function signatures, so please ensure you've updated all of your implementations to use the correct signature otherwise your layout will not behave correctly.

**Added**

```swift
// Replaces `backgroundLayoutRegion(in:forSectionAt: Int) -> LayoutRegion`
func collectionView(_ collectionView: UICollectionView,
    layout: UICollectionViewLayout,
    regionForBackgroundInSection section: Int) -> LayoutRegion
    
// Replaces `backgroundLayoutInsets(in:forSectionAt: Int) -> UIEdgeInsets` 
func collectionView(_ collectionView: UICollectionView,
    layout: UICollectionViewLayout,
    insetsForBackgroundInSection section: Int) -> UIEdgeInsets
    
// Allows you to 'align' cells within a specified section
func collectionView(_ collectionView: UICollectionView,
    layout: UICollectionViewLayout,
    alignmentInSection section: Int) -> LayoutAlignment
```

**Deprecated**

```swift
func backgroundLayoutRegion(in:forSectionAt: Int) -> LayoutRegion
func backgroundLayoutInsets(in:forSectionAt: Int) -> UIEdgeInsets
```
