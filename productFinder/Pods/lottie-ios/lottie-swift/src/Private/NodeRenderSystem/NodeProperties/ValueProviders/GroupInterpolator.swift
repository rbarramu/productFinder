//
//  KeyframeGroupInterpolator.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/22/19.
//

import CoreGraphics
import Foundation

/// A value provider that produces an array of values from an array of Keyframe Interpolators
final class GroupInterpolator<ValueType>: AnyValueProvider where ValueType: Interpolatable {
    var valueType: Any.Type {
        [ValueType].self
    }

    func hasUpdate(frame: CGFloat) -> Bool {
        let updated = keyframeInterpolators.first(where: { $0.hasUpdate(frame: frame) })
        return updated != nil
    }

    func value(frame: CGFloat) -> Any {
        let output = keyframeInterpolators.map { $0.value(frame: frame) as! ValueType }
        return output
    }

    /// Initialize with an array of array of keyframes.
    init(keyframeGroups: ContiguousArray<ContiguousArray<Keyframe<ValueType>>>) {
        keyframeInterpolators = ContiguousArray(keyframeGroups.map { KeyframeInterpolator(keyframes: $0) })
    }

    let keyframeInterpolators: ContiguousArray<KeyframeInterpolator<ValueType>>
}
