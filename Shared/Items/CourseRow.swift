//
//  CourseRow.swift
//  DC
//
//  Created by Luca Lo Forte on 5/3/21.
//

import SwiftUI

struct CourseRow: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "swift")
                .imageScale(.medium)
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(Color.blue)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text("SwiftUI")
                    .font(.subheadline)
                    .bold()
                
                Text("Description")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow()
    }
}
