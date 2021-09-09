//
//  TView.swift
//  FirstApp
//
//  Created by Long on 8/24/21.
//

import UIKit

public class CVView<T>: UIView,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var tView:UICollectionView!
    private var cellID = "cell"
    private var cellHeightCall : CallBackTwoReturn<UICollectionView,IndexPath,CGSize>?;//cell高
    private var cellCall : CallBackTwoReturn<UICollectionView,IndexPath,UICollectionViewCell>!;//cell
    private var cellRow : CallBackTwoReturn<UICollectionView,Int,Int>!;//
    private var cellSections : CallBackOneReturn<UICollectionView,Int>!;//cell
    
    private var cellSelected : CallBackTwo<UICollectionView,IndexPath>!;//cell
    
    var cvLayout:CVLayout?
    public var cellHeightDic = [Int:CGSize]()
    private var dataList = [T]()
    var count:Int{
        get{
            return dataList.count
        }
    }

   

    //
    public  init() {
        super.init(frame: CGRect.zero)
        
    }
    public  init(cellHeight:@escaping CallBackTwoReturn<UICollectionView,IndexPath,CGSize>,
         bindCell:@escaping (CallBackTwoReturn<UICollectionView,IndexPath,UICollectionViewCell>),
         cellSections:@escaping (CallBackOneReturn<UICollectionView,Int>),
         cellRow:@escaping (CallBackTwoReturn<UICollectionView,Int,Int>),
         cellSelected:@escaping (CallBackTwo<UICollectionView,IndexPath>)
         
    )
    {
        super.init(frame: CGRect.zero)
        
        CreateCollectionView()
        
        self.cellHeightCall = cellHeight;
        self.cellCall = bindCell;
        self.cellSections = cellSections;
        self.cellRow = cellRow;
        self.cellSelected = cellSelected;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //
    public   func CreateCollectionView()
    {
        let layout = UICollectionViewFlowLayout();
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSize(width: 10, height: 30)
        self.tView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 375, height: 100), collectionViewLayout:layout ).CreateCollectionView(delegate: self, superView: self, callback: { label in
            label.delegate = self;
            label.dataSource = self
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let rightConstraint = NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0)
            label.superview!.addConstraint(rightConstraint)
            //为父级控件添加约束
            let topConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
            label.superview!.addConstraint(topConstraint)
            
            let leftConstraint = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0)
            label.superview!.addConstraint(leftConstraint)
            
            let bottomConstraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
            label.superview!.addConstraint(bottomConstraint)
        })


        //
    }
    
    public  func UpdateFrame(){
        
        self.tView.frame = self.bounds;
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellSections(collectionView)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellRow(collectionView,section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        var cell = collectionView.dequeueConfiguredReusableSupplementary(using: T.self, for: indexPath)
        
        return cellCall(collectionView,indexPath);
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         cellSelected(collectionView,indexPath)
    }
    
    public  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //   self.tView.contentSize = CGSize(width: 414, height: 500)
        if(cellHeightCall != nil){
            let size = cellHeightCall!(collectionView,indexPath);
            cvLayout?.list = cellHeightDic
            return size;
            
        }
        return CGSize(width: 375, height: 100);
        
    }
    ///重置数据
    public func ResetData(list:[T]){
        self.dataList.removeAll()
        self.cellHeightDic.removeAll()
        self.dataList.append(contentsOf: list)
        self.tView.reloadData()
    }
    ///添加数据
    public func AddData(list:[T]){
        self.dataList.append(contentsOf: list)
        self.tView.reloadData()
    }
    ///移除
    public func RemoveAll(){
        self.dataList.removeAll()
        self.tView.reloadData()
    }
    
    ///移除某一个
    public func RemoveRow(row:Int){
        for i in (0 ..< dataList.count).reversed() {
            if(i == row){
                dataList.remove(at: i)
            }
        }
        self.tView.reloadData()
    }
    ///
    public  func List(row : Int) -> T{
        return dataList[row]
    }
    public  func ReloadData(){
        self.tView.reloadData()
    }
    
    ///设置流逝布局
    public func Setlayout(lineSpace:CGFloat,itemSpace:CGFloat,column:Int,layoutType:LayoutType = LayoutType.MinHeightLayout){

            let layout = CVLayout(layoutType: layoutType);
            layout.minimumLineSpacing = lineSpace;
            layout.minimumInteritemSpacing = itemSpace;
            self.cvLayout = layout
            self.cvLayout?.maxColumn = column;
            self.tView.collectionViewLayout = layout
    }
    
//    override func collectionViewContentSize() -> CGSize {
//        let collection = collectionView!
//        let width = collection.bounds.size.width
//        let height = max(posYColumn1, posYColumn2)
//
//        return CGSize(width: width, height: height)
//    }

}
