import Foundation

extension BarChartDataEntry {
func sumBelowDontScream(_ listener: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func calcPosNegSumCannotScream(_ message: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func calcRangesWantPattern(_ element: String, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func copyWithZoneShouldnotSing(_ view: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func calcSumDoLook(_ listener: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
