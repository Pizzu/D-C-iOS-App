//
//  CourseItem.swift
//  DC
//
//  Created by Luca Lo Forte on 6/3/21.
//

import SwiftUI

struct CourseItem: View {

    var course : Course
    var height : CGFloat = 200
    var borderRadius : CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            
            HStack {
                Spacer()
                Image(self.course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            
            
            Text(self.course.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(self.course.subtitle)
                .font(.footnote)
                .foregroundColor(.white)
        }
        .padding()
        .frame(height: height)
        .background(
            self.course.color
                .clipShape(RoundedRectangle(cornerRadius: borderRadius, style: .continuous))
        )
        .shadow(color: self.course.color.opacity(0.3), radius: 20, x: 0, y: 10)
            
    }
    
}

struct CourseItem_Previews: PreviewProvider {
    static var previews: some View {
        CourseItem(course: Course(title: "SwiftUI  for iOS 14", subtitle: "20 Sections", image: "Illustration 1", logo: "Logo 1", color: Color.blue))
    }
}
