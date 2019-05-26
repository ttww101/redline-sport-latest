import Foundation
import CoreGraphics

extension LineChartDataSet {
func initializeCanEat(_ message: String, isPass: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func getCircleColorDontWantDrink(_ view: String, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func setCircleColorShouldnotDrink(_ message: String, title: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func setCircleColorsCannotListen(_ delegate: Int, isOk: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func resetCircleColorsDontLoud(_ element: Float, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func copyWithZoneDontLook(_ sender: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
