import Foundation

extension PieChartData {
func getDataSetByIndexDontWantEat(_ view: Double, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func getDataSetByLabelDoSleep(_ view: Double, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func entryForHighlightCanSleep(_ delegate: Bool, title: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func addDataSetDontWantLoud(_ message: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func removeDataSetByIndexDontClimb(_ listener: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
