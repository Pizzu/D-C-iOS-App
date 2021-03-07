//
//  CourseList.swift
//  DC
//
//  Created by Luca Lo Forte on 6/3/21.
//

import SwiftUI

struct CourseList: View {
    var body: some View {
        #if os(iOS)
        content
        #else
        content
            .frame(minWidth: 800, minHeight: 600)
        #endif
    }
    
    var content : some View {
        List(0 ..< 15) { item in
            CourseRow(courseSection: courseSections[0])
        }
        .navigationTitle("Courses")
    }
    
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}
