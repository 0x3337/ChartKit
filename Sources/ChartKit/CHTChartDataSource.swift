//
//  CHTChartDataSource.swift
//  
//
//  Created by Mirsaid Patarov on 2021-05-10.
//

import UIKit

public protocol CHTChartDataSource: NSObjectProtocol {
  func numberOfPoints(in chart: CHTChart) -> Int

  func numberOfSerieas(in chart: CHTChart) -> Int

  func chart(_ chart: CHTChart, viewForLabelAt point: Int) -> UIView?

  func chart(_ chart: CHTChart, datasetForSerieasAt serieas: Int) -> CHTDataset
}

public extension CHTChartDataSource {
  func numberOfSerieas(in chart: CHTChart) -> Int {
    return 1
  }

  func chart(_ chart: CHTChart, viewForLabelAt point: Int) -> UIView? {
    return nil
  }
}
