import Foundation
import CoreGraphics

extension LineChartView {
func initializeDontRun(_ listener: Double, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
