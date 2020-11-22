//
//  TableRecord.swift
//  MidTerm
//
//  Created by Minh Tri on 11/21/20.
//

import UIKit

struct CellCoord {
    let col: Int
    let row: Int
}

protocol TableRecordDelegate {
    func ratioBetweenColumns(_ tableRecord: TableRecord) -> [Float]
}

protocol TableRecordDataSource {
    func tableRecord(_ tableRecord: TableRecord, cellForItemAt coord: CellCoord) -> UICollectionViewCell
    func tableRecord(_ tableRecord: TableRecord, cellForHeaderAt column: Int) -> UICollectionViewCell
    func numberItems(_ tableRecord: TableRecord) -> Int;
    func numberOfColumns(_ tableRecord: TableRecord) -> Int;
}

class TableRecord: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var datasource: TableRecordDataSource?
    var delegate: TableRecordDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configTableRecord() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func showTableRecord() {
        if self.subviews.isEmpty {
            guard let view = loadViewFromNib(nibName: "TableRecord") else {
                return
            }
            configTableRecord()
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    func register (nib: UINib?, forCellWithReuseIdentifier: String) {
        print(forCellWithReuseIdentifier)
        collectionView.register(nib, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
    }
    
    func dequeueReusableCell(withReuseIdentifier: String, for coord: CellCoord) ->  UICollectionViewCell {
        let numberOfColumn = (datasource?.numberOfColumns(self) ?? 0)
        let indexPath = IndexPath(
            row: coord.row * numberOfColumn + coord.col,
            section: 0
        )
   
        return collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath)
    }
}

extension TableRecord: UICollectionViewDelegate {
    
}

extension TableRecord: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (datasource?.numberItems(self) ?? 0) + (datasource?.numberOfColumns(self) ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let numberOfColumn = (datasource?.numberOfColumns(self) ?? 0)
        var cell: UICollectionViewCell?
       
        // Header
        if indexPath.row < numberOfColumn {
            cell = datasource?.tableRecord(
                self,
                cellForHeaderAt: indexPath.row
            )
        } else {
            
            let currentRowInTableCotent = (indexPath.row - numberOfColumn) / numberOfColumn
            let currentColumnInTableContent = (indexPath.row - numberOfColumn) % numberOfColumn
            cell = datasource?.tableRecord(
                self,
                cellForItemAt: CellCoord(
                    col: currentColumnInTableContent,
                    row: currentRowInTableCotent
                )
            )
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
}

extension TableRecord: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let ratioColumns = delegate?.ratioBetweenColumns(self) ?? [1]
        let nColumn = indexPath.row % ratioColumns.count
        let sumRatio = ratioColumns.reduce(0, { (sum, current) in
            sum + current
        })

        let widthCell = (Float(collectionView.bounds.width) / (sumRatio + 1)) * ratioColumns[nColumn]

        let heightCell: CGFloat = 100
        
        return CGSize(width: CGFloat(widthCell), height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

