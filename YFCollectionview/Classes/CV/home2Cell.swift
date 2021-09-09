
import UIKit

class home2Cell: BaseCVCell {
    //MARK:属性 ======
    var nameLabel:UILabel!
    var infoLabel:UILabel!
    var dateLabel:UILabel!
    
    override func CreateView() {
        InitSpace(left: 5, right: 5, Top: 5, Bottom: 5, lastSpace: 5, cellWidth: 300);
        containerView = UIView().CreateView( bgColor:UIColor.red,superView: self.contentView, callback: { label in
        })
        
        nameLabel = UILabel().CreateLabel(text: "", font: UIFont.boldSystemFont(ofSize: 15), textColor: UIColor.black, superView: containerView, callback: { label in
            label.numberOfLines = 1;
            label.clipsToBounds = true;
        })
        
        dateLabel = UILabel().CreateLabel(text: "", font: UIFont.boldSystemFont(ofSize: 14), textColor: UIColor.gray,textAlignment: NSTextAlignment.right, superView: containerView, callback: { label in
            label.numberOfLines = 1;

        })
        
        infoLabel = UILabel().CreateLabel(text: "", font: UIFont.boldSystemFont(ofSize: 14), textColor: UIColor.black, superView: containerView, callback: { (label) in
            label.numberOfLines = 0;

        })
        //自适应高，的view放到最后一个创建
    }
    override func UpdateViewFrame()
    {
        nameLabel.sizeToFit()
        nameLabel.width = containerView.width-5;
        nameLabel.x = 5;
        nameLabel.y = 5
        //
        dateLabel.sizeToFit()
        dateLabel.right = 5;
        dateLabel.centerY = nameLabel.centerY
        //
        infoLabel.width = containerView.width-5;
        infoLabel.sizeToFit()
        infoLabel.x = 5;
        infoLabel.y = nameLabel.bottom
    }
    
    //MAKR:--数据
    override func UpdateData<T>(cellWidth: CGFloat, data: T) {
        super.UpdateData(cellWidth: cellWidth, data: data)
        
        let model = data as! ListData;
        nameLabel.text = "标题"//
        infoLabel.text = model.typename;
        dateLabel.text = "\(model.row)"//Date().toFormat("yyyy-MM-dd-HH-mm")
        
       // PrintLog(message: model.typename)
        //
        UpdateContainer()
    }
    
    
}
