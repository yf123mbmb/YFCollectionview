//
//  HomeVC.swift
//  FirstApp
//
//  Created by Long on 8/26/21.
//

import UIKit

class LuYinVC: UIViewController {
    
    var tView : CVView<ListData>!;
    var loadBtn:UIButton!;
    
    
    var callUpdate : CallBackOne<String>?
    init<T>(callUpdate: @escaping CallBackOne<T>) {
        super.init(nibName: nil, bundle: nil)
        self.callUpdate = (callUpdate as! CallBackOne<String>)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    override func CreateView() {
        self.loadBtn = UIButton().CreateButton(text:"加载更多",bgColor: UIColor.blue, bgImage: "", superView: self.view, callback: { label in
      
        }, callAction: {[weak self] btn in
        })
 
    }
   
    
}

