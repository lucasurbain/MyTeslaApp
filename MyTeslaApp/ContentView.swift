//
//  ContentView.swift
//  MyTeslaApp
//
//  Created by lucas urbain on 24.02.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    HomeHeader()
                    CustomDivider()
                    CarSection()
                    CustomDivider()
                    CategoryView(title: "Quick Shortcuts", showEdit: true, actionItem: quickShortcuts)
                    CustomDivider()
                    CategoryView(title: "Recent Ations", actionItem: recentActions)
                    CustomDivider()
                    AllSetings()
                    ReorderButton()
                }
                .padding()
            }
            VoiceCommandButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkGray"))
        .foregroundColor(Color.white)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct VoiceCommandButton: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "mic.fill")
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .frame(width: 64, height: 64)
                    .background(Color("Green"))
                    .foregroundColor(Color("DarkGray"))
                    .clipShape(Circle())
                    .padding()
                    .shadow(radius: 10)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Model S".uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .foregroundColor(Color.white)
                    .background(Color("Red"))
                    .clipShape(Capsule())
                Text("Plaid")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            Spacer()
            HStack {
                Button(action: {}) {
                    GeneralButton(icon: "lock.fill")
                }
                Button(action: {}) {
                    GeneralButton(icon: "gear")
                }
            }
        }
    }
}

struct GeneralButton: View {
    
    var icon: String
    
    var body: some View {
        Image(systemName: icon)
            .imageScale(.large)
            .frame(width: 44, height: 44)
            .background(Color.white.opacity(0.05))
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
          
    }
}

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 0.5)
            .background(Color.white)
            .opacity(0.1)
    }
}

struct CarSection: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .center) {
                HStack {
                    Image(systemName: "battery.75")
                    Text("453 km".uppercased())
                }
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(Color("Green"))
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Parked")
                        .fontWeight(.semibold)
                    Text("Last Updated: 5 min ago")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            Image("Car")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct CategoryHeader: View {
    
    var title: String
    var showEdit: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            if showEdit {
                Button(action: {}) {
                    Text("Edit")
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                }
            }
        }
    }
}

struct CategoryView: View {
    
    var title: String
    var showEdit: Bool = false
    
    var actionItem: [ActionItem]
    
    var body: some View {
        VStack {
            CategoryHeader(title: title, showEdit: showEdit)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(actionItem, id: \.self) { item in
                        ActionButton(item: item)
                    }
                }
            }
        }
    }
}

struct ActionButton: View {
    
    var item: ActionItem
    
    var body: some View {
        VStack(alignment: .center) {
            GeneralButton(icon: item.icon)
            Text(item.text)
                .frame(width: 72)
                .font(.system(size: 12, weight: .semibold, design: .default))
                .multilineTextAlignment(.center)
        }
    }
}

struct ActionItem: Hashable {
    var icon: String
    var text: String
}

let quickShortcuts: [ActionItem] = [
    ActionItem(icon: "bolt.fill", text: "Charging"),
    ActionItem(icon: "fanblades.fill", text: "Fan On"),
    ActionItem(icon: "music.note", text: "Media Controls"),
    ActionItem(icon: "bolt.car", text: "Close Charge Port")
]

let recentActions: [ActionItem] = [
    ActionItem(icon: "arrow.up.square", text: "Open Trunk"),
    ActionItem(icon: "fanblades", text: "Fan Off"),
    ActionItem(icon: "person.fill.viewfinder", text: "Summon")
]

struct AllSetings: View {
    var body: some View {
        VStack {
            CategoryHeader(title: "All Setings")
            LazyVGrid(columns: [GridItem(.fixed(170)),GridItem(.fixed(170))]) {
                SettingBlock(icon: "car.fill", title: "Controls", subtitle: "CAR LOCK", hasSubtitle: true)
                SettingBlock(icon: "fanblades.fill", title: "Climate", subtitle: "INTERIOR 24° C", hasSubtitle: true, backgroundColor: Color("Blue"))
                SettingBlock(icon: "location.fill", title: "Location",subtitle: "Bulle, Fribourg (CH)", hasSubtitle: true)
                SettingBlock(icon: "checkerboard.shield", title: "Security",subtitle: "3 EVENTS DETECTED", hasSubtitle: true)
                SettingBlock(icon: "sparkle", title: "Upgrades",subtitle: "1 UPGRADES AVAILABLE", hasSubtitle: true)
            }
        }
    }
}

struct SettingBlock: View {
    
    var icon: String
    var title: String
    var subtitle: String = ""
    
    var hasSubtitle: Bool = false
    
    var backgroundColor: Color = Color.white.opacity(0.05)
    
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            Image(systemName: icon)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                if hasSubtitle {
                    Text(subtitle.uppercased())
                        .font(.system(size: 8, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                }
            }
            .padding(.leading, 5)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16) .stroke(Color.white.opacity(0.1), lineWidth: 0.5))
    }
}

struct ReorderButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Reorder Groups")
                .font(.caption)
                .padding(.vertical, 8)
                .padding(.horizontal, 24)
                .background(Color.white.opacity(0.05))
                .clipShape(Capsule())
        }
    }
}
