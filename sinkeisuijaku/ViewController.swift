//
//  ViewController.swift
//  sinkeisuijaku
//
//  Created by 保坂篤志 on 2021/06/13.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var cardArray = [Int]()
    var labelArray = [String]()
    @IBOutlet var collectionView: UICollectionView!
    var numMemory: Int?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.label.text = labelArray[indexPath.row]
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        labelArray[indexPath.row] = String(cardArray[indexPath.row])
        collectionView.reloadData()
        judge(num: indexPath.row)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        var array = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13]
        for _ in 0 ..< array.count {
            let num = Int.random(in: 1 ... array.count)
            cardArray.append(array[num-1])
            array.remove(at: num-1)
        }
        
        labelArray = ["裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏","裏"]
        
        collectionView.reloadData()
    }
    
    func judge(num: Int) {
        if numMemory == nil {
            numMemory = num
        }else {
            if cardArray[numMemory!] == cardArray[num] {
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                    self.cardArray.remove(at: num)
                    self.cardArray.remove(at: self.numMemory!)
                    self.labelArray.remove(at: num)
                    self.labelArray.remove(at: self.numMemory!)
                    self.numMemory = nil
                    self.collectionView.reloadData()
                }
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                    self.labelArray[num] = "裏"
                    self.labelArray[self.numMemory!] = "裏"
                    self.numMemory = nil
                    self.collectionView.reloadData()
                }
            }
        }
    }


}

