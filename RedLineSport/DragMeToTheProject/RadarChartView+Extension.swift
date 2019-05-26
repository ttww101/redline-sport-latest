import Foundation
import CoreGraphics

extension RadarChartView {
func initializeCannotRun(_ target: String, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func calcMinMaxCannotRun(_ listener: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func notifyDataSetChangedDontWantWalk(_ view: String, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func drawDoSpeak(_ message: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func indexForAngleDontPattern(_ listener: Double, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
