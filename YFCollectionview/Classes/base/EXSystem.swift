//
//  EXTableViewCell.swift
//  FirstApp
//
//  Created by Long on 8/21/21.
//

import UIKit


///设置cell高
public typealias CallBack = ()->()
public typealias CallBackOne<T1> = (T1)->()
public typealias CallBackTwo<T1,T2> = (T1,T2)->()
public typealias CallBackTwoReturn<T1,T2,T3> = (T1,T2) -> (T3)
public typealias CallBackOneReturn<T1,T2> = (T1) -> (T2)


//
extension UIView{
    @objc func CreateView(){};
    ///创建uiview
    func CreateView(bgColor:UIColor=UIColor.white,superView:UIView,callback:(UIView)->()) ->UIView
    {
        let label = self;
        superView.addSubview(label);
        label.backgroundColor = bgColor;
        callback(label);
        return label
    }
    
    ///创建UILabel
    func CreateLabel(text:String="",font:UIFont=UIFont.systemFont(ofSize: 14),textColor:UIColor=UIColor.white,textAlignment:NSTextAlignment = NSTextAlignment.left ,superView:UIView,callback:(UILabel)->()) ->UILabel
    {
        let label = self as! UILabel;
        superView.addSubview(label);
        label.text = text;
        label.font = font;
        label.textAlignment = textAlignment;
        label.textColor = textColor;
        label.numberOfLines = 0;
        callback(label);
        return label
    }
    ///创建UIImage
    func CreateImage(text:String="",superView:UIView,callback:(UIImageView)->()) ->UIImageView
    {
        let label = self as! UIImageView;
        superView.addSubview(label);
        label.image = UIImage(named: text);
        callback(label);
        return label
    }
    
    ///创建Button
    func CreateButton(text:String="",font:UIFont=UIFont.systemFont(ofSize: 14),textColor:UIColor=UIColor.white,bgColor:UIColor = UIColor.clear,bgImage:String,superView:UIView,callback:(UIButton)->(),callAction:@escaping (UIView)->()) ->UIButton
    {
        let label = self as! UIButton;
        superView.addSubview(label);
        label.setTitle("", for: UIControl.State.normal);
        label.backgroundColor = bgColor
        if(bgImage != ""){
            label.setBackgroundImage(UIImage(named: bgImage), for: UIControl.State.normal)
        }
        
        label.addAction { button in
            callAction(button);
        }
        callback(label);
        superView.layoutIfNeeded()
        //label.layoutIfNeeded()
        UILabel().CreateLabel(text: text, font: font,textColor: textColor, textAlignment: .center, superView: label) { view in
            
            view.frame = label.bounds;
        }
        return label
    }
    
 
    
    
    
   
    
    
    ///创建CreateTableView 需要rxswift
    func CreateCollectionView(delegate:Any,bgColor:UIColor = UIColor.clear,superView:UIView,callback:(UICollectionView)->()) ->UICollectionView
    {
        let label = self as! UICollectionView;
        superView.addSubview(label);
        label.backgroundColor = bgColor

        callback(label);
        return label
    }
    
    
    //
    
}
//VC
extension UIViewController{
    @objc func CreateView(){};
    
    
}
//MARK:-添加按钮block点击
let cmButtonAssociatedkey = UnsafeRawPointer.init(bitPattern: "cmButtonAssociatedkey".hashValue)
extension UIButton {
    func addAction(for controlEvents: UIControl.Event,action:@escaping (UIButton)->()) {
        objc_setAssociatedObject(self, cmButtonAssociatedkey!, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(cmButtonClick), for: controlEvents)
    }
    func addAction(_ action:@escaping (UIButton)->()) {
        
        objc_setAssociatedObject(self, cmButtonAssociatedkey!, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(cmButtonClick), for: .touchUpInside)
    }
    
    @objc func cmButtonClick() {
        
        if let action = objc_getAssociatedObject(self, cmButtonAssociatedkey!) as? (UIButton)->() {
            action(self)
        }
    }
    
}








//UIView的扩展
extension UIView{
    
    //x position
    var x : CGFloat{
        
        get {
            
            return frame.origin.x
            
        }
        
        set(newVal){
            
            var tempFrame : CGRect = frame
            tempFrame.origin.x     = newVal
            frame                  = tempFrame
            
        }
    }
    
    
    //y position
    var y : CGFloat{
        
        get {
            
            return frame.origin.y
            
        }
        
        
        set(newVal){
            
            var tempFrame : CGRect = frame
            tempFrame.origin.y     = newVal
            frame                  = tempFrame
            
        }
    }
    
    
    //height
    var height : CGFloat{
        
        get {
            
            return frame.size.height
            
        }
        
        set(newVal){
            
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
            
        }
    }
    
    
    // width
    var width : CGFloat {
        
        get {
            
            return frame.size.width
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }
    
    
    
    // left
    var left : CGFloat {
        
        get {
            
            return x
        }
        
        set(newVal) {
            
            x = newVal
        }
    }
    
    
    // right
    var right : CGFloat {
        
        get {
            
            return x + width
        }
        
        set(newVal) {
            
            x = superview!.width-width-newVal;//newVal - width
        }
    }
    
    
    // top
    var top : CGFloat {
        
        get {
            
            return y
        }
        
        set(newVal) {
            
            y = newVal
        }
    }
    
    // bottom
    var bottom : CGFloat {
        
        get {
            
            return y + height
        }
        
        set(newVal) {
            
            y = newVal - height
        }
    }
    
    //centerX
    var centerX : CGFloat {
        
        get {
            
            return center.x
        }
        
        set(newVal) {
            
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
    //centerY
    var centerY : CGFloat {
        
        get {
            
            return center.y
        }
        
        set(newVal) {
            
            center = CGPoint(x: center.x, y: newVal)
        }
    }
    //middleX
    var middleX : CGFloat {
        
        get {
            
            return width / 2
        }
    }
    
    //middleY
    var middleY : CGFloat {
        
        get {
            
            return height / 2
        }
    }
    
    //middlePoint
    var middlePoint : CGPoint {
        
        get {
            
            return CGPoint(x: middleX, y: middleY)
        }
    }
    
    
    
}
