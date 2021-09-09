//
//Created by ESJsonFormatForMac on 21/08/19.
//

import UIKit

class SuperData : NSObject{
    required override init() {super.init()}
    
    var YFmessage: String?
    
    var YFdata: DataInfo?
    
    var YFcode: String?
    

 
    
}
class DataInfo : NSObject{
    required override init() {super.init()}
    
    var list: [ListData]?
    
}

class ListData : NSObject{
    required override init() {super.init()}
    
    var ID: Int = 0
    
    var typename: String?
    
    var tageufo: Int = 0
    
    var row : Int = 0
    
}

