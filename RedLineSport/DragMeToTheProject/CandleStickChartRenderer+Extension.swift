import Foundation
import CoreGraphics
    import UIKit

extension CandleStickChartRenderer {
func drawDataShouldnotWalk(_ delegate: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func drawDataSetDontWantSpeak(_ delegate: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func drawValuesDontWalk(_ sender: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func drawExtrasCannotClimb(_ view: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func drawHighlightedDoRun(_ para: String, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
