//
//  CourseItem.swift
//  DC
//
//  Created by Luca Lo Forte on 6/3/21.
//

import SwiftUI

struct CourseItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            
            Image("Illustration 1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("SwiftUI for iOS 14")
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("20 Sections")
                .font(.footnote)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
    }
}

struct CourseItem_Previews: PreviewProvider {
    static var previews: some View {
        CourseItem()
    }
}
