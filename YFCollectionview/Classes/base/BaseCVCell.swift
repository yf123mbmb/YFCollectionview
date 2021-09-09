
import UIKit
class BaseCVCell: UICollectionViewCell {
    ///容器宽
    var containerViewWidth:CGFloat {
        get{
            return  self.cellWidth-SpaceLeft-SpaceRight
        }
    };
    ///容器高
    var containerViewHeight:CGFloat {
        get{
            return self.containerView.subviews.last!.bottom + SpaceBottonN
        }
    };
    ///容器
    var containerView:UIView!
    
    
    var cellWidth:CGFloat = 0;
    ///上下左右间距， 最外层
    var SpaceLeft:CGFloat = 5;
    var SpaceRight:CGFloat = 5;
    var SpaceTop:CGFloat = 5;
    var SpaceBottom:CGFloat = 5;
    ///间距上下， 内层
    var SpaceBottonN:CGFloat = 5;
    
    
    func InitSpace(left:CGFloat,right:CGFloat,Top:CGFloat,Bottom:CGFloat,lastSpace:CGFloat,cellWidth:CGFloat){
        self.cellWidth = cellWidth;
        ///上下左右间距， 最外层
        self.SpaceLeft = left;
        self.SpaceRight = right;
        self.SpaceTop = Top;
        self.SpaceBottom = Bottom;
        ///间距上下， 内层
        self.SpaceBottonN = lastSpace;
    }
    override func CreateView() {
        
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        CreateView()
        UpdateContainer();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //设置容器容器的大小，
    func UpdateContainer()
    {
        UpdateViewFrame();
        self.contentView.frame = self.bounds
        containerView.x = SpaceLeft;
        containerView.y = SpaceTop;
        self.backgroundColor = UIColor.black
        containerView.width = containerViewWidth;
        containerView.height = containerViewHeight;
        if(self.bounds.width<=0){
            containerView.isHidden = true;
        }else{
            containerView.isHidden = false;

            
        }

    }
    
    
    func UpdateCellHeight<T>(cellWidth:CGFloat,data:T)->CGSize{
        UpdateData(cellWidth: cellWidth,data: data);
        //    UpdateFrame()
        if(self.containerView != nil){
            //设置容器的高
            let height = self.containerView.bottom;
            //设置cell的高
            let h = height + SpaceBottom ;//上下间距
            //
            
            return CGSize(width:cellWidth, height: h);
        }else{
            return CGSize.zero
        }
    }
    
    
    func UpdateViewFrame()
    {
        
    }
    
    //MAKR:--数据
    func UpdateData<T>(cellWidth:CGFloat,data:T)
    {
        self.cellWidth = cellWidth;
        UpdateContainer()
    }
    
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//      var layoutAttributes =    super.preferredLayoutAttributesFitting(layoutAttributes)
//
//        layoutAttributes.frame = CGRect(x: 0, y: layoutAttributes.frame.minY, width:  50, height:  layoutAttributes.frame.height)
//  
//        return layoutAttributes
//    }
    
}

