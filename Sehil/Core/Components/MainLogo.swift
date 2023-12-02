//
//  MainLogo.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import SwiftUI

struct MainLogo: View {
    var body: some View {
        Image("LogoWoB")
            .resizable()
            .scaledToFit()
            .frame(width: 8 * 5, height: 8 * 5)
    }
}

#Preview {
    MainLogo()
}
