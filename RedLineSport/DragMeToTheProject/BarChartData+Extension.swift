import Foundation
import CoreGraphics

extension BarChartData {
func groupBarsDoJump(_ delegate: Float, title: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func groupWidthCannotEat(_ listener: Float, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
