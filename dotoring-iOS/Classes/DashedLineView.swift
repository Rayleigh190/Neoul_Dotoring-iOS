//
//  DashedLineView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/14.
//

import UIKit

class DashedLineView: UIView {
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        drawLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       
        drawLine()
   }
   
   // 뷰의 크기가 변경될 때 호출되는 메서드
   override func layoutSubviews() {
       super.layoutSubviews()
       
       // 부모 뷰의 너비를 기반으로 뷰의 프레임 크기를 설정
       let shapeLayer = self.layer as! CAShapeLayer
       let path = UIBezierPath()
       path.move(to: CGPoint(x: 0, y: self.frame.size.height / 2))
       path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height / 2))
       shapeLayer.path = path.cgPath
   }
    
    func drawLine() {
        let shapeLayer = self.layer as! CAShapeLayer
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [5, 5] // 점선 패턴을 설정 (5 포인트 점, 5 포인트 공백)
    }
    
}
