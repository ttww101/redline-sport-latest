import Foundation
import CoreGraphics

extension ScatterChartView {
func initializeCanScream(_ delegate: String, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
