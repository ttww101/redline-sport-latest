import Foundation
import CoreGraphics

extension ScatterChartDataSet {
func setScatterShapeCanEat(_ listener: Int, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func rendererShouldSing(_ view: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func copyWithZoneDontWantEat(_ delegate: String, isOk: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
