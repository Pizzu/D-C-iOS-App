//
//  CoursesView.swift
//  DC
//
//  Created by Luca Lo Forte on 5/3/21.
//

import SwiftUI

struct CoursesView: View {
    @Namespace var namespace
    @State private var show = false
    @State private var selectedCourse : Course? = nil
    
    var body: some View {
        ZStack {
            #if os(iOS)
            content
                .navigationBarHidden(true)
            
            if self.selectedCourse != nil {
                fullContent
                    .background(VisualEffectBlur(blurStyle: .systemMaterial).ignoresSafeArea())
            }
            #else
            content
            
            if self.selectedCourse != nil {
                fullContent
                    .background(VisualEffectBlur().ignoresSafeArea())
            }
            #endif
        }
        .navigationTitle("Courses")
    }
    
    var content : some View {
        ScrollView {
            VStack(spacing: 0) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                    ForEach(courses) { course in
                        VStack {
                            CourseItem(course: course)
                                .matchedGeometryEffect(id: course.id, in: namespace, isSource: !show)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                        self.show = true
                                        self.selectedCourse = course
                                    }
                                }
                        }
                        .matchedGeometryEffect(id: "container\(course.id)", in: namespace, isSource: !show)
                        .zIndex(1)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                Text("Latest sections")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 240), spacing: 16)], spacing: 16) {
                    ForEach(courseSections) { courseSection in
                        CourseRow(courseSection: courseSection)
                    }
                }
                .padding()
            }
            
        }
    }
    
    var fullContent : some View {
            VStack {
                CourseItemDetail(course: self.selectedCourse!, namespace: namespace)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                            self.show = false
                            self.selectedCourse = nil
                        }
                    }
            }
            .zIndex(2)
            .frame(maxWidth: 712)
            .frame(maxWidth: .infinity)
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
