import Foundation
import CoreGraphics

extension BubbleChartView {
func initializeDoEat(_ view: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
