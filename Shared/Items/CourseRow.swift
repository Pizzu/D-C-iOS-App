//
//  CourseRow.swift
//  DC
//
//  Created by Luca Lo Forte on 5/3/21.
//

import SwiftUI

struct CourseRow: View {
    
    var courseSection : CourseSection
    
    var body: some View {
        HStack(alignment: .center) {
            Image(courseSection.logo)
                .frame(width: 48, height: 48)
                .background(courseSection.color)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(courseSection.title)
                    .font(.subheadline)
                    .bold()
                
                Text(courseSection.subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow(courseSection: courseSections[0])
    }
}
