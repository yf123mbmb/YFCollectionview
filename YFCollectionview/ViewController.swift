//
//  ViewController.swift
//  CVView
//
//  Created by Long on 9/2/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CreateTableView();
        // Do any additional setup after loading the view.
    }
    
    
    
    var tView : YFCollectionview<ListData>!;
    func CreateTableView()
    {
        //创建Tableview
        let cellID = "cell";//注册cell
        let layoutType = LayoutType.MinHeightLayout;//布局方式
        //
        let tViewLeftSpace:CGFloat = 5;//左间距
        let tViewRightSpace:CGFloat = 5;//右间距
        let cellItemSpace:CGFloat = 10;//上下间距
        let cellItemLineSpace:CGFloat = 5;
        let column:CGFloat = 4;//几列
        let superViewWidth:CGFloat = 414;//父视图的宽
        //
        let space = cellItemLineSpace * (column-1)
        let cellWidth:CGFloat = (superViewWidth-space-tViewLeftSpace-tViewRightSpace)/column;
        self.tView = (YFCollectionview<ListData>(cellHeight: { cv, ip in
            let myCell : home2Cell = cv.dequeueReusableCell(withReuseIdentifier: cellID, for: ip) as! home2Cell
            let model:ListData = self.tView.List(row:ip.row)
            let h:CGSize =  myCell.UpdateCellHeight(cellWidth:(cellWidth),data: model)
            self.tView.cellHeightDic.updateValue(h, forKey: ip.row)
            return h
        }, bindCell: { cv, ip in
            let myCell : home2Cell = cv.dequeueReusableCell(withReuseIdentifier: cellID, for: ip) as! home2Cell
            let model:ListData = self.tView.List(row:ip.row)
            model.row = ip.row;
            myCell.UpdateData(cellWidth:cellWidth,data: model)
            return myCell
        }, cellSections: { cv in
            return 1
        }, cellRow: { cv, section in
            return self.tView.count
        }, cellSelected: { cv, ip in
            
        }).CreateView(superView: self.view, callback: { view in
            let label = view as! YFCollectionview<ListData>
            label.frame = CGRect(x: tViewLeftSpace, y: 200, width: superViewWidth-tViewLeftSpace-tViewRightSpace, height: 500)
            //注册
            label.tView.register(home2Cell.self, forCellWithReuseIdentifier: cellID)
            //设置布局，方式
            label.Setlayout(lineSpace: cellItemLineSpace, itemSpace: cellItemSpace,column: Int(column),layoutType: layoutType)
            label.backgroundColor = UIColor.red
            
            label.ResetData(list: self.GetData())
            //上啦刷新，下啦加载
//            let header = MJRefreshNormalHeader {
//                DataCenter.LoadData {[weak self] data in
//                    self?.tView.ResetData(list: data.YFdata!.list!)
//
//                    label.tView.mj_header?.endRefreshing()
//                } failCall: {
//                    label.tView.mj_header?.endRefreshing()
//                }
//            }
//            let footer = MJRefreshBackNormalFooter {
//                DataCenter.LoadData {[weak self] data in
//                    self?.tView.AddData(list: data.YFdata!.list!)
//                    label.tView.mj_footer?.endRefreshing()
//                } failCall: {
//                    label.tView.mj_footer?.endRefreshing()
//                }
//            }
//            header.beginRefreshing()
//            label.tView.mj_footer = footer;
//            label.tView.mj_header = header;
            
        })) as? YFCollectionview<ListData>
    }

    func GetData()->[ListData]{
        
        var list = [ListData]();
        for i in 0..<50 {
            let data =  ListData();
            data.typename = "哈啊=\(i==1 ? "哈啊哈啊哈啊哈啊哈啊哈啊哈啊哈啊哈啊哈啊" : "哈啊=")"
            data.ID = i;
            data.tageufo = i
            data.row = i
            list.append(data);
        }
        return list
        
    }
}

