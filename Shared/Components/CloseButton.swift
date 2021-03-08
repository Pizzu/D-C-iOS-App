//
//  CloseButton.swift
//  DC (iOS)
//
//  Created by Luca Lo Forte on 8/3/21.
//

import SwiftUI

struct CloseButton: View {
    
    var color : Color = Color.gray
    
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .resizable()
            .frame(width: 35, height: 35)
            .foregroundColor(color)
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
