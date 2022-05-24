//
//  ViewExtension.swift
//  AcademyUI
//
//  Created by HANNA P C FERREIRA on 18/05/22.
//

import Foundation
import SwiftUI
import Combine


/// See `View.onChange(of: value, perform: action)` for more information
struct ChangeObserver<Base: View, Value: Equatable>: View {
    let base: Base
    let value: Value
    let action: (Value) -> Void

    let model = Model()

    var body: some View {
        if model.update(value: value) {
            DispatchQueue.main.async { self.action(self.value) }
        }
        return base
    }

    class Model {
        private var savedValue: Value?
        func update(value: Value) -> Bool {
            guard value != savedValue else { return false }
            savedValue = value
            return true
        }
    }
}

extension View {
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func corneredBorder(_ radius: CGFloat, corners: UIRectCorner, color: Color, lineWidth: CGFloat) -> some View {
        overlay(RoundedCorner(radius: radius, corners: corners).stroke(color, lineWidth: lineWidth))
    }
    
    func toast(message: String, color: Color, isShowing: Binding<Bool>, duration: TimeInterval = 3) -> some View {
        modifier(ToastModifier(message: message, isShowing: isShowing, duration: duration, color: color))
    }
    
    /// Adds a modifier for this view that fires an action when a specific value changes.
    ///
    /// You can use `onChange` to trigger a side effect as the result of a value changing, such as an Environment key or a Binding.
    ///
    /// `onChange` is called on the main thread. Avoid performing long-running tasks on the main thread.
    /// If you need to perform a long-running task in response to value changing, you should dispatch to a background queue.
    ///
    /// The new value is passed into the closure. The previous value may be captured by the closure to compare it to the new value.
    /// For example, in the following code example, PlayerView passes both the old and new values to the model.
    ///
    /// ```
    /// struct PlayerView : View {
    ///   var episode: Episode
    ///   @State private var playState: PlayState
    ///
    ///   var body: some View {
    ///     VStack {
    ///       Text(episode.title)
    ///       Text(episode.showTitle)
    ///       PlayButton(playState: $playState)
    ///     }
    ///   }
    ///   .onChange(of: playState) { [playState] newState in
    ///     model.playStateDidChange(from: playState, to: newState)
    ///   }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - value: The value to check against when determining whether to run the closure.
    ///   - action: A closure to run when the value changes.
    ///   - newValue: The new value that failed the comparison check.
    /// - Returns: A modified version of this view
    func onChangeValue<Value: Equatable>(of value: Value, perform action: @escaping (_ newValue: Value) -> Void) -> ChangeObserver<Self, Value> {
        ChangeObserver(base: self, value: value, action: action)
    }
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
            if hidden {
                if !remove {
                    self.hidden()
                }
            } else {
                self
            }
        }
    
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func bottomSheet<Content: View>(
            isPresented: Binding<Bool>,
            height: CGFloat,
            topBarHeight: CGFloat = 30,
            topBarCornerRadius: CGFloat? = nil,
            contentBackgroundColor: Color = Color(.systemBackground),
            topBarBackgroundColor: Color = Color(.systemBackground),
            showTopIndicator: Bool = true,
            @ViewBuilder content: @escaping () -> Content
        ) -> some View {
            ZStack {
                self
                BottomSheet(isPresented: isPresented,
                            height: height,
                            topBarHeight: topBarHeight,
                            topBarCornerRadius: topBarCornerRadius,
                            topBarBackgroundColor: topBarBackgroundColor,
                            contentBackgroundColor: contentBackgroundColor,
                            showTopIndicator: showTopIndicator,
                            content: content)
            }
        }
    
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
