//
//  CoursesView.swift
//  DC
//
//  Created by Luca Lo Forte on 5/3/21.
//

import SwiftUI

struct CoursesView: View {
    @Namespace var namespace
    @Namespace var namespaceTwo
    @State private var show = false
    @State private var isDisabled = false
    @State private var selectedCourse : Course? = nil
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    var body: some View {
        ZStack {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                content
                tabBar
            } else {
                sideBar
            }
            fullContent
                .background(VisualEffectBlur(blurStyle: .systemMaterial).ignoresSafeArea())
            
            #else
            content
            fullContent
                .background(VisualEffectBlur().ignoresSafeArea())
            
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
                                        self.show.toggle()
                                        self.selectedCourse = course
                                        isDisabled = true
                                    }
                                }
                                .disabled(isDisabled)
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
                        #if os(iOS)
                        NavigationLink(destination: CourseItemDetail(course: courses[0], namespace: namespaceTwo)) {
                            CourseRow(courseSection: courseSection)
                        }
                        #else
                        CourseRow(courseSection: courseSection)
                        #endif
                    }
                }
                .padding()
            }
            
        }
        .navigationTitle("Courses")
    }
    
    @ViewBuilder
    var fullContent : some View {
        if selectedCourse != nil {
            ZStack(alignment: .topTrailing) {
                CourseItemDetail(course: self.selectedCourse!, namespace: namespace)
                    
                CloseButton()
                    .padding(16)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                            show.toggle()
                            selectedCourse = nil
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isDisabled = false
                            }
                        }
                    }
            }
            .zIndex(2)
            .frame(maxWidth: 712)
            .frame(maxWidth: .infinity)
        }
    }
    
    var tabBar : some View {
        TabView {
            NavigationView {
                content
            }
            .tabItem {
                Image(systemName: "book.closed")
                Text("Courses")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("Tutorials")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "tv")
                Text("Livestreams")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "mail.stack")
                Text("Certificates")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
    
    @ViewBuilder
    var sideBar : some View {
        #if os(iOS)
        NavigationView {
            List {
                NavigationLink(destination: content) {
                    Label("Courses", systemImage: "book.closed")
                }
                NavigationLink(destination: CourseList()) {
                    Label("Tutorials", systemImage: "list.bullet.rectangle")
                }
                Label("Livestreams", systemImage: "tv")
                Label("Certificates", systemImage: "mail.stack")
                Label("Search", systemImage: "magnifyingglass")
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Learn")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "person.crop.circle")
                }
            }
            
            content
        }
        #endif
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
