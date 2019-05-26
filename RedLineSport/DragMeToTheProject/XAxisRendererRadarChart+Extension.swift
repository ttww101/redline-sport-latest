import Foundation
import CoreGraphics
    import UIKit

extension XAxisRendererRadarChart {
func renderAxisLabelsCanLook(_ element: Float, isOk: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func drawLabelDontListen(_ target: Int, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func renderLimitLinesDoListen(_ delegate: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
