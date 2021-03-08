//
//  CourseItemDetail.swift
//  DC
//
//  Created by Luca Lo Forte on 7/3/21.
//

import SwiftUI

struct CourseItemDetail: View {
    var course : Course
    var namespace : Namespace.ID
    
    @State private var showModal : Bool = false
    
    var body: some View {
        #if os(iOS)
        content
            .edgesIgnoringSafeArea(.all)
        #else
        content
        #endif
    }
    
    var content: some View {

        VStack{
            ScrollView {
                CourseItem(course: course, height: 350, borderRadius: 0)
                    .matchedGeometryEffect(id: course.id, in: namespace)
                
                VStack {
                    ForEach(courseSections) { courseSection in
                        CourseRow(courseSection: courseSection)
                            .onTapGesture {
                                self.showModal = true
                            }
                            .sheet(isPresented: self.$showModal, content: {
                                CourseSectionDetail()
                            })
                        Divider()
                    }
                }
                .padding()
                
            }
            
        }
        .background(Color("Background 1"))
        .matchedGeometryEffect(id: "container\(course.id)", in: namespace)
    }
}

struct CourseItemDetail_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        CourseItemDetail(course: Course(title: "SwiftUI  for iOS 14", subtitle: "20 Sections", image: "Illustration 1", logo: "Logo 1", color: Color.blue), namespace: namespace)
    }
}

