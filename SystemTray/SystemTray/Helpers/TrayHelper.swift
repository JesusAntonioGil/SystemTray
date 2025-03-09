//
//  TrayHelper.swift
//  SystemTray
//
//  Created by Jesus Antonio Gil on 8/3/25.
//

import SwiftUI


struct TrayConfig {
    var maxDetent: PresentationDetent
    var cornerRadius: CGFloat = 30
    var isInteractiveDissmissDisabled: Bool = false
    
    var horizontalPadding: CGFloat = 15
    var bottomPadding: CGFloat = 15
}


extension View {
    @ViewBuilder
    func systemTrayView<Content: View>(_ show: Binding<Bool>,
                                       config: TrayConfig = .init(maxDetent: .fraction(0.99)),
                                       @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .sheet(isPresented: show) {
                content()
                    .background(.background)
                    .clipShape(.rect(cornerRadius: config.cornerRadius))
                    .padding(.horizontal, config.horizontalPadding)
                    .padding(.bottom, config.bottomPadding)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                // Presentation Configurations
                    .presentationDetents([config.maxDetent])
                    .presentationCornerRadius(0)
                    .presentationBackground(.clear)
                    .presentationDragIndicator(.hidden)
                    .interactiveDismissDisabled(config.isInteractiveDissmissDisabled)
                    .background(RemoveSheetShadow())
            }
    }
}


fileprivate struct RemoveSheetShadow: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let shadowView = view.dropShadowView {
                shadowView.layer.shadowColor = UIColor.clear.cgColor
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}


extension UIView {
    var dropShadowView: UIView? {
        if let superview, String(describing: type(of: superview)) == "UIDropShadowView" {
            return superview
        }
        
        return superview?.dropShadowView
    }
}
