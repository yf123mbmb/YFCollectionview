
import UIKit
public enum LayoutType {
    ///从左到右依次
    case LeftLayout
    ///最小高布局方式
    case MinHeightLayout

}

 class CVLayout: UICollectionViewFlowLayout {
    var maxHeight:CGFloat = 0;//
    var maxColumn:Int = 0;
    var list = [Int:CGSize]()
    var layoutType = LayoutType.MinHeightLayout
    var rowList = [Int:[CGSize]]()

    //    添加一个数组属性，用来存放每个item的布局信息
    var attributeArray:Array<UICollectionViewLayoutAttributes>?
    //    实现必要的构造方法
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    //    自定义一个初始化构造方法
    init(layoutType:LayoutType = LayoutType.MinHeightLayout) {
        super.init()
        self.layoutType = layoutType
        
        // self.contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        //   YangFan()
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    override func prepare() {
        //调用父类的准备方法
        super.prepare()
        if(self.layoutType == LayoutType.MinHeightLayout){
            UpdateCellHeightMinHeight()
        }else{
            UpdateCellHeightLeft()
        }
    }
    //
    
    //将设置好存放每个item的布局信息返回
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        return    attributeArray
        //  return attributeArray
    }
    
    
    
    func UpdateCellHeightMinHeight()
    {
        self.rowList.removeAll()
        attributeArray = Array<UICollectionViewLayoutAttributes>()

        var colSizeArr:[[RowHeightData]] = [[RowHeightData]](repeating: [RowHeightData()], count: self.maxColumn)
        var colHeightArr = [CGFloat](repeating: 0, count: self.maxColumn);

        for i in 0..<self.list.count {
            let size:CGSize = self.list[i]!

            if(i < self.maxColumn){
                let x = CGFloat(i) * (self.minimumLineSpacing+size.width)
                let rect = CGRect(x: x, y: 0, width: size.width, height: size.height)
                var arr = [RowHeightData]()
                arr.append(RowHeightData(index: i, frameArr: rect))
                colSizeArr[i] = arr;
                colHeightArr[i] += size.height + self.minimumInteritemSpacing
            }else{
                let min : RowHeightData = sortColmunHeightArray(colHeightArr, isMax: false)
                
                let x = CGFloat(min.column) * (self.minimumLineSpacing+size.width)
                let y = colHeightArr[min.column]// + self.minimumInteritemSpacing
                let rect = CGRect(x: x, y: y, width: size.width, height: size.height)
                
                colSizeArr[min.column].append(RowHeightData(index: i, frameArr: rect));
                colHeightArr[min.column] += size.height + self.minimumInteritemSpacing
            }
        }
        
        var maxCountArr = [Int](repeating: 0, count: colSizeArr.count);
        for i in 0 ..< colSizeArr.count {
            let size:[RowHeightData] = colSizeArr[i]
            maxCountArr[i] = size.count
        }
        
        let maxCount = sortArrayInt(maxCountArr, isMax: true)
        for row in 0..<maxCount {
            for i in 0 ..< colSizeArr.count {
                
                let size:[RowHeightData] = colSizeArr[i]
                
                if(row<size.count)
                {
                    let data:RowHeightData = size[row];

                    //设置IndexPath，默认为一个分区
                    let indexPath = IndexPath(item: data.row, section: 0)
                    //创建布局属性类
                    let attris = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    
                    attris.frame = data.rect;
                    attributeArray?.append(attris)
                }
            }
        }
        
        self.maxHeight = sortColmunHeightArray(colHeightArr, isMax: true).height

        if(self.list.count<=0){
            attributeArray?.removeAll()
        }
    }
    
    func UpdateCellHeightLeft()
    {
        self.rowList.removeAll()
        var arr = [CGSize]()
        let allRow = self.list.count / self.maxColumn //+  (self.list.count % 3) == 0 ? 0 : 1

        for i in 0..<self.list.count {
            let row = i/self.maxColumn
            if(i%self.maxColumn == 0){
                arr = [CGSize]()
            }
            arr.append(self.list[i]!)
            
            if(arr.count == self.maxColumn || allRow == row){
                self.rowList.updateValue(arr, forKey: row)
           
            }
     

        }
        

        attributeArray = Array<UICollectionViewLayoutAttributes>()
        var colArr = [CGFloat](repeating: 0, count: self.maxColumn);
        var index = 0
        for i in 0..<self.rowList.count {
            let arr:[CGSize] = self.rowList[i]!
            
            for a in 0..<arr.count {
                let size = arr[a]
                
                //设置IndexPath，默认为一个分区
                let indexPath = IndexPath(item: index, section: 0)
                //创建布局属性类
                let attris = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                

                for b in stride(from: (i-1 <= 0 ? 0 : i-1), to: i, by: 1) {
                    let topArr:[CGSize] = self.rowList[b]!
                    colArr[a] += (topArr[a].height + self.minimumInteritemSpacing)
                }
                
                let y = colArr[a]
                attris.frame = CGRect(x: (self.minimumLineSpacing+size.width)*CGFloat(a), y: CGFloat(y), width: size.width, height: CGFloat(size.height))
                attributeArray?.append(attris)

                index+=1
            }
            


        }
        let arrH:[CGSize] = self.rowList[self.rowList.count-1] ?? [CGSize.zero]
      
        self.maxHeight = sortArray(colArr, isMax: true) + sortArraySize(arrH, isMax: true)
        if(self.list.count<=0){
            attributeArray?.removeAll()
        }
    }
    
   
    override open var collectionViewContentSize: CGSize {
        
        return CGSize(width: (self.collectionView?.width)! * CGFloat(self.collectionView!.numberOfSections), height: self.maxHeight);
    }
    
    

    
    func sortArray(_ nums: [CGFloat],isMax:Bool) -> (CGFloat) {
        if (nums.count<=0){
            return 0
        }
        var min:CGFloat = nums[0]
        var max:CGFloat = nums[0]
        
        for i in 0..<nums.count {
            if nums[i] < min {
                min = nums[i]
            }
            if nums[i] > max {
                max = nums[i]
            }
        }
        
        return isMax ? max : min
    }
    func sortArrayInt(_ nums: [Int],isMax:Bool) -> (Int) {
        if (nums.count<=0){
            return 0
        }
        var min:Int = nums[0]
        var max:Int = nums[0]
        
        for i in 0..<nums.count {
            if nums[i] < min {
                min = nums[i]
            }
            if nums[i] > max {
                max = nums[i]
            }
        }
        
        return isMax ? max : min
    }
    
    
    func sortColmunHeightArray(_ nums: [CGFloat],isMax:Bool) -> (RowHeightData) {
        if (nums.count<=0){
            return RowHeightData(c: 0, h: 0)
        }
        
        var min:CGFloat = nums[0]
        var max:CGFloat = nums[0]
        var index = 0
        for i in 0..<nums.count {
            if nums[i] < min {
                min = nums[i]
                if(!isMax){
                    index = i
                }

            }
            if nums[i] > max {
                max = nums[i]
                if(isMax){
                    index = i
                }
            }
        }
        let val = isMax ? max : min

        return RowHeightData(c: index, h: val)

    }
    
    
    func sortArraySize(_ nums: [CGSize],isMax:Bool) -> (CGFloat) {
        if (nums.count<=0){
            return 0
        }
        var min:CGSize = nums[0]
        var max:CGSize = nums[0]
        
        for i in 0..<nums.count {
            if nums[i].height < min.height {
                min.height = nums[i].height
            }
            if nums[i].height > max.height {
                max.height  = nums[i].height
            }
        }
        
        return isMax ? max.height  : min.height
    }
}


class RowHeightData {
    public var column:Int!
    public var height:CGFloat!
    public var rect:CGRect!
    public var row:Int!


    init(index:Int=0,frameArr:CGRect = CGRect.zero,c:Int=0,h:CGFloat=0) {
        column = c;
        height = h
        row = index
        rect = frameArr
    }
}
