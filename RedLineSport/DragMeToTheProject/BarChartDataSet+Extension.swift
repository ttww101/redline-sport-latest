import Foundation
import CoreGraphics

extension BarChartDataSet {
func initializeShouldSpeak(_ para: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func calcEntryCountIncludingStacksWantScream(_ para: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func calcStackSizeShouldListen(_ target: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func calcMinMaxCanJump(_ listener: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func copyWithZoneShouldnotListen(_ target: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
