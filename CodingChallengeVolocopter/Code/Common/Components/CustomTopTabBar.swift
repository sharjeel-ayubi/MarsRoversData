//
//  CustomTopTabBar.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 09/11/2023.
//

import SwiftUI

struct CustomTopTabBar: View {
    let tabs: [Tabs]
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            ForEach(tabs, id: \.self) { tab in
                TabBarButton(text: tab.name, isSelected: .constant(selectedTab == tab))
                    .onTapGesture { onButtonTapped(tab: tab) }
            }
            Spacer()
            
        }
        .border(width: 1, edges: [.bottom], color: Color("MainColor"))
    }
    
    private func onButtonTapped(tab: Tabs) {
        selectedTab = tab
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Avenir", size: 16))
            .padding(.bottom,10)
            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: Color("MainColor"))
    }
}

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct CustomTopTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTopTabBar(tabs: Tabs.allCases, selectedTab: .constant(.curiosity))
    }
}
