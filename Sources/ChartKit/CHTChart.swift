//
//  CHTChart.swift
//
//
//  Created by Mirsaid Patarov on 2021-05-10.
//

import UIKit

public class CHTChart: UIView {
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually

    return stackView
  }()

  private lazy var graphLayer: CALayer = {
    let layer = CAShapeLayer()

    return layer
  }()

  public var numberOfPoints: Int {
    return dataSource?.numberOfPoints(in: self) ?? 0
  }

  public var numberOfSerieas: Int {
    return dataSource?.numberOfSerieas(in: self) ?? 0
  }

  public var heightForLabels: CGFloat = .leastNormalMagnitude

  public weak var dataSource: CHTChartDataSource?

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func draw(_ rect: CGRect) {
    super.draw(rect)

    setupLabel()
    setupGraph(rect)
  }
}

private extension CHTChart {
  func setupUI() {
    addSubview(stackView)
    addConstraints(withVisualFormat: "H:|[v0]|", views: stackView)
    addConstraints(withVisualFormat: "V:[v0]|", views: stackView)

    layer.addSublayer(graphLayer)
  }

  func setupGraph(_ rect: CGRect) {
    let graphWidth = rect.size.width
    let graphHeight = rect.size.height - heightForLabels

    let barWidth = graphWidth / CGFloat(numberOfPoints)

    graphLayer.sublayers?.forEach { $0.removeFromSuperlayer() }

    for serieas in 0..<numberOfSerieas {
      guard let dataset = dataSource?.chart(self, datasetForSerieasAt: serieas) else {
        // TODO: Add throw exception
        continue
      }

      let maxValue = dataset.data.max()
      for (point, value) in dataset.data.enumerated() {
        if value == 0 {
          continue
        }

        let centerX = barWidth * CGFloat(point) + barWidth / 2

        let width: CGFloat = 20
        let height = graphHeight * CGFloat(value / maxValue!)

        addRoundedRectLayer(
          CGRect(x: centerX - width / 2, y: graphHeight - height, width: width, height: height),
          cornerRadius: 4,
          fillColor: dataset.tintColor
        )
      }
    }
  }

  func setupLabel() {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    for point in 0..<numberOfPoints {
      let view: UIView = {
        guard let view = dataSource?.chart(self, viewForLabelAt: point) else {
          return UIView()
        }

        return view
      }()

      stackView.addArrangedSubview(view)
    }
  }
}

private extension CHTChart {
  func addRoundedRectLayer(_ rect: CGRect, cornerRadius: CGFloat, fillColor: UIColor? = nil) {
    let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)

    let layer = CAShapeLayer()
    layer.path = path.cgPath
    layer.fillColor = fillColor?.cgColor
    layer.lineWidth = 0

    graphLayer.addSublayer(layer)
  }
}
