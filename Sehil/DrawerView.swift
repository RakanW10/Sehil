//
//  Drawer.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import SwiftUI

public struct DrawerView<Menu: View, Content: View>: View {
    @Binding private var isOpened: Bool
    private let menu: Menu
    private let content: Content

    init(
        isOpened: Binding<Bool>,
        @ViewBuilder menu: () -> Menu,
        @ViewBuilder content: () -> Content
    ) {
        _isOpened = isOpened
        self.menu = menu()
        self.content = content()
    }

    public var body: some View {
      ZStack(alignment: .leading) {
        content

        if isOpened {
          Color.clear
             .contentShape(Rectangle())
            .onTapGesture {
              if isOpened {
                isOpened.toggle()
              }
            }
          menu
            .transition(.move(edge: .leading))
            .zIndex(1)
        }
      }
      .animation(.spring(), value: isOpened)
    }
}
