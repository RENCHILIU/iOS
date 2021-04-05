//
//  SwiftStockChart.swift
//  StockTrade
//
//  Created by liurenchi on 3/29/21.
//

import UIKit

//MARK: - SwiftStockChart -
class SwiftStockChart: UIView {
  
  enum ValueLabelPositionType {
    case Left, Right, Mirrored
  }
  
  typealias LabelForIndexGetter = (_ index: NSInteger) -> String
  typealias LabelForValueGetter = (_ value: CGFloat) -> String
  
  //Index Label Properties
  var labelForIndex: LabelForIndexGetter!
  var indexLabelFont: UIFont?
  var indexLabelTextColor: UIColor?
  var indexLabelBackgroundColor: UIColor?
  
  // Value label properties
  //var labelForIndex
  var labelForValue: LabelForValueGetter!
  var valueLabelFont: UIFont?
  var valueLabelTextColor: UIColor?
  var valueLabelBackgroundColor: UIColor?
  var valueLabelPosition: ValueLabelPositionType?
  
  // Number of visible step in the chart
  var gridStep: Int?
  var verticalGridStep: Int?
  var horizontalGridStep: Int?
  
  // Margin of the chart
  var margin: CGFloat?
  
  var axisWidth: CGFloat?
  var axisHeight: CGFloat?
  
  // Decoration parameters, let you pick the color of the line as well as the color of the axis
  var axisColor: UIColor?
  var axisLineWidth: CGFloat?
  
  // Chart parameters
  var color: UIColor?
  var fillColor: UIColor?
  var lineWidth: CGFloat?
  
  // Data points
  var displayDataPoint: Bool?
  var dataPointColor: UIColor?
  var dataPointBackgroundColor: UIColor?
  var dataPointRadius: CGFloat?
  
  // Grid parameters
  var drawInnerGrid: Bool?
  var innerGridColor: UIColor?
  var innerGridLineWidth: CGFloat?
  // Smoothing
  var bezierSmoothing: Bool?
  var bezierSmoothingTension: CGFloat?
  
  // Animations
  var animationDuration: CGFloat?
  
  var timeRange: ChartTimeRange!
  var dataPoints = [ChartPoint]()
  var layers = [CAShapeLayer]()
  var axisLabels = [UILabel]()
  var minValue: CGFloat?
  var maxValue: CGFloat?
  var initialPath: CGMutablePath?
  var newPath: CGMutablePath?
  
  
  //Implementation
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
    color = UIColor.green
    fillColor = color?.withAlphaComponent(0.25)
    verticalGridStep = 3
    horizontalGridStep = 3
    margin = 5.0
    axisWidth = self.frame.size.width - 2 * margin!
    axisHeight = self.frame.size.height - 2 * margin!
    axisColor = UIColor(white: 0.5, alpha: 1.0)
    innerGridColor = UIColor(white: 0.9, alpha: 1.0)
    drawInnerGrid = true
    bezierSmoothing = false
    bezierSmoothingTension = 0.2
    lineWidth = 1
    innerGridLineWidth = 0.5
    axisLineWidth = 1
    animationDuration = 0.0
    displayDataPoint = false
    dataPointRadius = 1.0
    dataPointColor = color
    dataPointBackgroundColor = color
    
    indexLabelBackgroundColor = UIColor.clear
    indexLabelTextColor = UIColor(white: 1, alpha: 0.6)
    indexLabelFont = UIFont(name: "HelveticaNeue-Light", size: 10)
    
    valueLabelBackgroundColor = UIColor.clear
    valueLabelTextColor = UIColor(white: 1, alpha: 0.6)
    valueLabelFont = UIFont(name: "HelveticaNeue-Light", size: 11)
    valueLabelPosition = .Right
    
    
  }
  
  func setChartPoints(points: [ChartPoint]) {
    
    if points.isEmpty { return }
    
    dataPoints = points
    
    computeBounds()
    
    
    if maxValue!.isNaN { maxValue = 1.0 }
    
    for i in 0..<verticalGridStep! {
      
      let yVal = axisHeight! + margin! - CGFloat((i + 1)) * axisHeight! / CGFloat(verticalGridStep!)
      let p = CGPoint(x: (valueLabelPosition! == .Right ? axisWidth! : 0), y: yVal)
      
      let text = labelForValue(minValue! + (maxValue! - minValue!) / CGFloat(verticalGridStep!) * CGFloat((i + 1)))
      
      let rect = CGRect(x: margin!,  y: p.y + 2, width: self.frame.size.width - margin! * 2 - 4.0, height: 14.0)
      let width = text.boundingRect(with: rect.size,
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    attributes:[NSAttributedString.Key.font : valueLabelFont!],
                                    context: nil).size.width
      
      let xPadding = 6
      let xOffset = width + CGFloat(xPadding)
      
      let label = UILabel(frame: CGRect(x: p.x - xOffset + 5.0, y: p.y, width: width + 2, height: 14))
      label.text = text
      label.font = valueLabelFont
      label.textColor = valueLabelTextColor
      label.textAlignment = .center
      label.backgroundColor = valueLabelBackgroundColor!
      
      self.addSubview(label)
      axisLabels.append(label)
      
    }
    
    for i in 0..<(horizontalGridStep! + 1) {
      
      let text = labelForIndex(i)
      
      let p = CGPoint(x: margin! + CGFloat(i) * (axisWidth! / CGFloat(horizontalGridStep!)) * 1.0, y: axisHeight! + margin!)
      
      
      let rect = CGRect(x: margin!, y: p.y + 2, width: self.frame.size.width - margin! * 2 - 4.0, height: 14)
      let width = text.boundingRect(with: rect.size,
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    attributes:[NSAttributedString.Key.font : indexLabelFont!],
                                    context: nil).size.width
      
      let label = UILabel(frame: CGRect(x: p.x - 5.0, y: p.y + 5.0, width: width + 2, height: 14))
      label.text = text
      label.font = indexLabelFont!
      label.textAlignment = .left
      label.textColor = indexLabelTextColor!
      label.backgroundColor = indexLabelBackgroundColor!
      
      self.addSubview(label)
      axisLabels.append(label)
      
    }
    
    self.color = UIColor.white
    //UIColor(red: (127/255), green: (50/255), blue: (198/255), alpha: 1)
    strokeChart()
    self.setNeedsDisplay()
    
  }
  
  override func draw(_ rect: CGRect) {
    if !dataPoints.isEmpty {
      drawGrid()
    }
  }
  
  func drawGrid() {
    
    if drawInnerGrid! {
      
      guard let ctx = UIGraphicsGetCurrentContext() else { return }
      UIGraphicsPushContext(ctx)
      ctx.setLineWidth(axisLineWidth!)
      ctx.setStrokeColor(axisColor!.cgColor)
      ctx.move(to: CGPoint(x: margin!, y: margin!))
      ctx.addLine(to: CGPoint(x: margin!, y: axisHeight! + margin! + 3))
      ctx.strokePath()
      
      for i in 0..<horizontalGridStep! {
        
        ctx.setStrokeColor(innerGridColor!.cgColor)
        ctx.setLineWidth(innerGridLineWidth!)
        
        let point = CGPoint(x: CGFloat((1 + i)) * axisWidth! / CGFloat(horizontalGridStep!) * 1.0 + margin!, y: margin!)
        ctx.move(to: CGPoint(x: point.x, y: point.y))
        ctx.addLine(to: CGPoint(x: point.x, y: axisHeight! + margin!))
        ctx.strokePath()
        
        ctx.setStrokeColor(axisColor!.cgColor)
        ctx.setLineWidth(axisLineWidth!)
        
        ctx.move(to: CGPoint(x: point.x - 0.5, y: axisHeight! + margin!))
        ctx.addLine(to: CGPoint(x: point.x - 0.5, y: axisHeight! + margin! + 3))
        
        ctx.strokePath()
        
      }
      
      for i in 0..<(verticalGridStep! + 1) {
        
        let v = maxValue! - (maxValue! - minValue!) / CGFloat(verticalGridStep! * i)
        
        if(v == minValue!) {
          ctx.setLineWidth(axisLineWidth!)
          ctx.setStrokeColor(axisColor!.cgColor)
        } else {
          ctx.setStrokeColor(innerGridColor!.cgColor)
          ctx.setLineWidth(innerGridLineWidth!)
        }
        
        let point = CGPoint(x: margin!, y: CGFloat(i) * axisHeight! / CGFloat(verticalGridStep!) + margin!)
        ctx.move(to: CGPoint(x: point.x, y: point.y))
        ctx.addLine(to: CGPoint(x: axisWidth! + margin!, y: point.y))
        
        ctx.strokePath()
        
      }
    }
    
  }
  
  func clearChartData(){
    for layer in layers {
      layer.removeFromSuperlayer()
    }
    layers.removeAll()
    
    for lbl in axisLabels {
      lbl.removeFromSuperview()
    }
    axisLabels.removeAll()
  }
  
  func strokeChart(){
    
    let scale = axisHeight! / (maxValue! - minValue!)
    
    let path = getLinePath(scale: scale, smoothing: bezierSmoothing!, close: false)
    
    let pathLayer = CAShapeLayer()
    pathLayer.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y + (margin! * 1.2), width: self.bounds.size.width, height: self.bounds.size.height)
    pathLayer.bounds = self.bounds
    pathLayer.path = path.cgPath
    pathLayer.fillColor = nil
    pathLayer.strokeColor = color!.cgColor
    pathLayer.lineWidth = lineWidth!
    pathLayer.lineJoin = CAShapeLayerLineJoin.round
    
    self.layer.addSublayer(pathLayer)
    layers.append(pathLayer)
    
  }
  
  func computeBounds(){
    minValue = CGFloat(MAXFLOAT)
    maxValue = CGFloat(-MAXFLOAT)
    
    for i in 0..<dataPoints.count {
      let value = dataPoints[i].close
      
      if value < minValue! {
        minValue = value
      }
      
      if value > maxValue! {
        maxValue = value
      }
      
      //  maxValue = getUpperRoundNumber(value: maxValue!, gridStep: verticalGridStep!)
      
      if minValue! < 0 {
        
        var step: CGFloat
        
        if verticalGridStep! > 3 {
          step = abs(maxValue! - minValue!) / CGFloat(verticalGridStep! - 1)
        } else {
          step = max(abs(maxValue! - minValue!) / 2, max(abs(minValue!), abs(maxValue!)))
        }
        
        step = getUpperRoundNumber(value: step, gridStep: verticalGridStep!)
        
        var newMin: CGFloat
        var newMax: CGFloat
        
        if abs(minValue!) > abs(maxValue!) {
          let m = ceil(abs(minValue!) / step)
          
          newMin = step * m * (minValue! > 0 ? 1 : -1)
          newMax = step * (CGFloat(verticalGridStep!) - m) * (maxValue! > 0 ? 1 : -1)
        } else {
          let m = ceil(abs(maxValue!) / step)
          
          newMax = step * m * (maxValue! > 0 ? 1 : -1)
          newMin = step * (CGFloat(verticalGridStep!) - m) * (minValue! > 0 ? 1 : -1)
        }
        
        if(minValue! < newMin) {
          newMin -= step
          newMax -=  step
        }
        
        if(maxValue! > newMax + step) {
          newMin += step
          newMax += step
        }
        
        minValue = newMin
        maxValue = newMax
        
        if(maxValue! < minValue!) {
          let tmp = maxValue!
          maxValue = minValue
          minValue = tmp
        }
        
      }
    }
  }
  
  func getUpperRoundNumber(value: CGFloat, gridStep: Int) -> CGFloat {
    if value <= 0.0 {
      return 0.0
    }
    
    let logValue = log10f(Float(value))
    let scale = powf(10.0, floorf(logValue))
    var n = ceil(value / CGFloat(scale * 4))
    
    let tmp = Int(n) % gridStep
    
    if tmp != 0 {
      n += CGFloat(gridStep - tmp)
    }
    
    return n * CGFloat(scale) / 4.0
  }
  
  func setGridStep(gridStep: Int) {
    verticalGridStep = gridStep
    horizontalGridStep = gridStep
  }
  
  func getPointForData(index: Int, scale: CGFloat) -> CGPoint {
    if index < 0 || index >= dataPoints.count{
      return CGPoint.zero
    }
    
    let dataPoint = dataPoints[index].close
    
    var properWidth = axisWidth!
    if timeRange! == .OneDay {
      properWidth = ((CGFloat(dataPoints.count) / 391.0) * axisWidth!) - margin!
    }
    
    var xDenom = CGFloat(dataPoints.count - 1)
    if xDenom == 0 { xDenom = 1 }
    
    var yDenom = maxValue! - minValue!
    if yDenom == 0 { yDenom = 0 }
    
    let pt = CGPoint(
      x: margin! + CGFloat(index) * ( properWidth / xDenom ),
      y: ( axisHeight! - (( (dataPoint - minValue!) / yDenom ) * axisHeight!) ) + margin!
    )
    
    return pt
    
    // for % based charts
    //        var xValue = margin! + CGFloat(index) * (properWidth / CGFloat(dataPoints.count - 1))
    //        let startingPoint = maxValue! / (maxValue! + fabs(minValue!))
    //
    //        var yValue = (axisHeight! * startingPoint) - ((CGFloat(dataPoint) / ((maxValue! + fabs(minValue!)) * startingPoint)) * (axisHeight! * startingPoint))
    //
    //        let isYNan = isnan(yValue)
    //        if isYNan { yValue = 0.0 }
    //
    //        let isXNan = isnan(xValue)
    //        if isXNan { xValue = 0.0 }
    //
    //        CGPoint(xValue,yValue)
    
    
  }
  
  func getLinePath(scale: CGFloat, smoothing: Bool, close: Bool) -> UIBezierPath {
    
    let path = UIBezierPath()
    
    for i in 0..<dataPoints.count {
      if i > 0 {
        path.addLine(to: getPointForData(index: i, scale: scale))
      } else {
        path.move(to: getPointForData(index: i, scale: scale))
      }
    }
    
    return path
  }
  
  
  func timeLabelsForTimeFrame(range: ChartTimeRange) -> [String] {
    
    switch range {
    case .OneDay:
      return ["9:30am", "10", "11", "12pm", "1", "2", "3", "4"]
    case .FiveDays:
      
      let weekday = Calendar(identifier: .gregorian).component(.weekday, from: Date())
      switch weekday {
      case 1:
        return ["Mon", "Tues", "Wed", "Thu", "Fri"]
      case 2:
        return ["Tues", "Wed", "Thu", "Fri", "Mon"]
      case 3:
        return ["Wed", "Thu", "Fri", "Mon", "Tues"]
      case 4:
        return ["Thu", "Fri", "Mon", "Tues", "Wed"]
      case 5:
        return ["Fri", "Mon", "Tues", "Wed", "Thu"]
      case 6:
        return ["Mon", "Tues", "Wed", "Thu", "Fri"]
      case 7:
        return ["Mon", "Tues", "Wed", "Thu", "Fri"]
      default: ()
      }
    case .TenDays:
      let weekday = Calendar(identifier: .gregorian).component(.weekday, from: Date())
      switch weekday {
      //sunday
      case 1:
        return ["Mon", "Wed", "Fri", "Mon", "Wed", "Fri"]
      case 2:
        return ["Wed", "Fri", "Mon", "Wed", "Fri", "Mon"]
      case 3:
        return ["Wed", "Fri", "Mon", "Wed", "Fri", "Tues"]
      case 4:
        return ["Fri", "Mon", "Wed", "Fri", "Mon", "Wed"]
      case 5:
        return ["Wed", "Mon", "Wed", "Fri", "Tues", "Thu"]
      case 6:
        return ["Mon", "Wed", "Fri", "Mon", "Wed", "Fri"]
      //saturday
      case 7:
        return ["Mon", "Wed", "Fri", "Mon", "Wed", "Fri"]
      default: ()
      }
    case .OneMonth:
      
      let fmt = DateFormatter()
      fmt.dateFormat = "dd MMM"
      let offset = Double(-6*24*60*60)
      let start = Date()
      let fifthString = fmt.string(from: start.addingTimeInterval(offset))
      let fourthString = fmt.string(from: start.addingTimeInterval(offset * 2))
      let thirdString = fmt.string(from: start.addingTimeInterval(offset * 3))
      let secondString = fmt.string(from: start.addingTimeInterval(offset * 4))
      let firstString = fmt.string(from: start.addingTimeInterval(offset * 5))
      
      return[firstString, secondString, thirdString, fourthString, fifthString, ""]
    case .ThreeMonths:
      let fmt = DateFormatter()
      fmt.dateFormat = "dd MMM"
      let offset = Double(-15*24*60*60)
      let start = Date()
      let fifthString = fmt.string(from: start.addingTimeInterval(offset))
      let fourthString = fmt.string(from: start.addingTimeInterval(offset * 2))
      let thirdString = fmt.string(from: start.addingTimeInterval(offset * 3))
      let secondString = fmt.string(from: start.addingTimeInterval(offset * 4))
      let firstString = fmt.string(from: start.addingTimeInterval(offset * 5))
      
      return[firstString, secondString, thirdString, fourthString, fifthString, ""]
    case .OneYear:
      let fmt = DateFormatter()
      fmt.dateFormat = "MMM"
      let offset = Double(-80*24*60*60)
      let start = Date()
      let fifthString = fmt.string(from: start.addingTimeInterval(offset))
      let fourthString = fmt.string(from: start.addingTimeInterval(offset * 2))
      let thirdString = fmt.string(from: start.addingTimeInterval(offset * 3))
      let secondString = fmt.string(from: start.addingTimeInterval(offset * 4))
      let firstString = fmt.string(from: start.addingTimeInterval(offset * 5))
      
      return[firstString, secondString, thirdString, fourthString, fifthString, ""]
      
    case .FiveYears:
      let fmt = DateFormatter()
      fmt.dateFormat = "yyyy"
      let offset = Double(-365*24*60*60)
      let start = Date()
      let fifthString = fmt.string(from: start.addingTimeInterval(offset))
      let fourthString = fmt.string(from: start.addingTimeInterval(offset * 2))
      let thirdString = fmt.string(from: start.addingTimeInterval(offset * 3))
      let secondString = fmt.string(from: start.addingTimeInterval(offset * 4))
      let firstString = fmt.string(from: start.addingTimeInterval(offset * 5))
      
      return[firstString, secondString, thirdString, fourthString, fifthString, ""]
    }
    return []
  }
}
