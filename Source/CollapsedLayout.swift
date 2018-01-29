//
//  CollapsedLayout.swift
//  CampcotCollectionView
//
//  Created by Vadim Morozov on 1/29/18.
//  Copyright © 2018 Touchlane LLC. All rights reserved.
//

public class CollapsedLayout: UICollectionViewFlowLayout {
    public var targetSection: Int = 0
    public var offsetCorrection: CGFloat = 0
    
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = self.collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    private var headersAttributes: [UICollectionViewLayoutAttributes] = []
    private var itemsAttributes: [[UICollectionViewLayoutAttributes]] = []
    
    override public func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else {
            return
        }
        
        guard let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else {
            return
        }
        
        guard let dataSource = collectionView.dataSource else {
            return
        }
        self.headersAttributes = []
        self.itemsAttributes = []
        self.contentHeight = 0
        
        let numberOfSections = dataSource.numberOfSections!(in: collectionView)
        for section in 0..<numberOfSections {
            let headerSize = delegate.collectionView!(collectionView, layout: self, referenceSizeForHeaderInSection: section)
            let height = headerSize.height
            let width = headerSize.width
            let indexPath = IndexPath(row: 0, section: section)
            let attributes = UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                with: indexPath
            )
            attributes.frame = CGRect(x: 0, y: self.contentHeight, width: width, height: height)
            self.headersAttributes.append(attributes)
            self.contentHeight += height
            
            self.itemsAttributes.append([])
            let numberOfItems = dataSource.collectionView(collectionView, numberOfItemsInSection: section)
            for row in 0..<numberOfItems {
                let indexPath = IndexPath(row: row, section: section)
                let itemSize = delegate.collectionView!(collectionView, layout: self, sizeForItemAt: indexPath)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                if row % 2 == 0 {
                    attributes.frame = CGRect(
                        x: 0,
                        y: self.contentHeight,
                        width: itemSize.width,
                        height: 0
                    )
                }
                else {
                    attributes.frame = CGRect(
                        x: self.collectionViewContentSize.width - itemSize.width,
                        y: self.contentHeight,
                        width: itemSize.width,
                        height: 0
                    )
                }
                attributes.isHidden = true
                self.itemsAttributes[section].append(attributes)
            }
        }
        print("Collapsed content height \(contentHeight)")
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in headersAttributes {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override public func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.headersAttributes[indexPath.section]
    }
    
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) ->  UICollectionViewLayoutAttributes? {
        return self.itemsAttributes[indexPath.section][indexPath.row]
    }
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {
            return proposedContentOffset
        }
        var targetOffset = proposedContentOffset
        targetOffset.y = offsetCorrection
        for section in 0..<self.targetSection {
            let height = self.headersAttributes[section].frame.size.height
            targetOffset.y += height
        }
        let emptySpace = collectionView.bounds.size.height - (self.contentHeight - targetOffset.y)
        if emptySpace > 0 {
            targetOffset.y = targetOffset.y - emptySpace
        }
        return targetOffset
    }
}
