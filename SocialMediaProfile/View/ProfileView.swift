//
//  ProfileView.swift
//  SocialMediaProfile
//
//  Created by Ahmet OZBERK on 9.04.2022.
//

import SwiftUI

struct ProfileView: View {
    @State private var pickerValue:Int = 0
    @State private var tabSelection:Int = 0
    @State var yazi = 0
    
    var storys:[StoryModel] = [
        StoryModel(image: "https://picsum.photos/200", name: "Hangout"),
        StoryModel(image: "https://picsum.photos/200", name: "New Years"),
        StoryModel(image: "https://picsum.photos/200", name: "Friends"),
        StoryModel(image: "https://picsum.photos/200", name: "Work"),
        StoryModel(image: "https://picsum.photos/200", name: "Office"),
        StoryModel(image: "https://picsum.photos/200", name: "Software"),
    ]
    
    var scrollViewContent:[TabBarModel] = [
        TabBarModel(image: "square.grid.2x2.fill", name: "Feeds"),
        TabBarModel(image: "video.fill", name: "Shorts"),
        TabBarModel(image: "person.2.fill", name: "Tag")
    ]
    
    let columns = [GridItem(spacing: 3),
                   GridItem(spacing:3),
                   GridItem(spacing: 3)]
    
    var body: some View {
        GeometryReader{ s in
            VStack{
                appBar()
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        photo(s: s)
                        userDescription()
                        staticticItems()
                        buttons(s:s)
                        Divider().padding(.horizontal).padding(.bottom,10)
                        storysWidget(s: s)
                        VStack {
                            HStack(spacing: 30){
                                ForEach(Array(scrollViewContent.enumerated()),id: \.offset){index, item in
                                    HStack{
                                        Image(systemName: item.image)
                                        Text(item.name)
                                            .fontWeight(.semibold)
                                            .font((tabSelection == scrollViewContent.firstIndex(of: item)) ? .system(size: 18) : .system(size: 15))
                                    }.foregroundColor((tabSelection == scrollViewContent.firstIndex(of: item)) ? Color.red : Color.gray)
                                        .onTapGesture {
                                            tabSelection = index
                                        }
                                }
                            }.padding(.top)
                            Divider().padding(.horizontal)
                        }
                        TabView(selection: $tabSelection) {
                            ForEach(Array(scrollViewContent.enumerated()),id: \.offset){index, item in
                                LazyVGrid(columns: columns,spacing: 5) {
                                    ForEach(0..<10, id: \.self){ i in
                                        AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(height: s.size.width*0.3)
                                        .cornerRadius(15)
                                        //.overlay(RoundedRectangle(cornerRadius: 15).stroke(, lineWidth: 0))
                                        .padding(3)
                                    }
                                }.tag(index)
                                    .padding(.horizontal)
                            }
                        }.onChange(of: tabSelection, perform: {index in
                            yazi = index
                            print("index = \(index)")
                        })
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: ((s.size.width*0.3 + 40)*10)/3)
                    }
                }
               
            }
        }
    }
    
    fileprivate func storysWidget(s:GeometryProxy) -> some View {
        return ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(storys){ item in
                    VStack{
                        AsyncImage(url: URL(string: item.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: s.size.width*0.2, height: s.size.width*0.2)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.pink, lineWidth: 4))
                        .padding(3)
                        Text(item.name)
                            .font(.system(size: 13))
                            .foregroundColor(Color.black.opacity(0.6))
                            .fontWeight(.semibold)
                    }
                }
            }.padding(.horizontal)
        }
    }
    
    fileprivate func buttons(s:GeometryProxy) -> some View {
        return HStack{
            Button(
                action: {}
            ){
                HStack{
                    Image(systemName: "person.fill.badge.plus").foregroundColor(.white)
                    Text("Follow").foregroundColor(.white).font(.body).fontWeight(.semibold)
                }
            }.frame(width: s.size.width*0.28).padding(.horizontal,30)
                .padding(.vertical,10)
                .background(.pink)
                .cornerRadius(20)
            
            Button(
                action: {}
            ){
                HStack{
                    Image(systemName: "ellipsis.bubble.fill").foregroundColor(.pink)
                    Text("Message").foregroundColor(.pink).font(.body).fontWeight(.semibold)
                }
            }.frame(width: s.size.width*0.28).padding(.horizontal,30)
                .padding(.vertical,10)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.pink, lineWidth: 2))
                .cornerRadius(20)
            
        }.padding()
    }
    
    fileprivate func staticticItems() -> some View {
        return HStack{
            statisticWidget(title: "267", desc: "Posts")
            Divider()
            statisticWidget(title: "24,278", desc: "Followers")
            Divider()
            statisticWidget(title: "237", desc: "Following")
        }.padding(.vertical,3)
            .fixedSize(horizontal: true, vertical: true)
    }
    
    fileprivate func statisticWidget(title:String,desc:String) -> some View {
        return VStack {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            Text(desc)
                .foregroundColor(Color.black.opacity(0.7))
                .font(.body)
        }
        .padding(.horizontal,10)
    }
    
    fileprivate func userDescription() -> some View {
        return VStack {
            Text("Lisa Land")
                .font(.title)
                .padding(.top,5)
                .padding(.bottom,1)
            Text("Flutter and SwiftUI Developer")
                .font(.body)
            Text("Lorem ipsum dolor sit amet, consectetur dipiscing elit, sed do eiusmod tempor...")
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.vertical,2)
            Text("www.lisaland.com")
                .font(.callout)
                .foregroundColor(.blue)
                .fontWeight(.semibold)
        }
    }
    
    fileprivate func photo(s:GeometryProxy) -> some View {
        return ZStack{
            AsyncImage(url: URL(string: "https://avazavazdergi.com/wp-content/uploads/2021/06/Girl-in-Red_-by-Chris-Almeida-1.png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: s.size.width*0.3, height: s.size.width*0.3)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black.opacity(0.3), lineWidth: 0.5))
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 15,height: 15)
                .foregroundColor(Color.white)
                .frame(width: 30, height: 30, alignment: .center)
                .background(Color.pink)
                .cornerRadius(5)
                .offset(x: 40, y: 45)
        }.padding(.top,10)
    }
    
    fileprivate func appBar() -> some View {
        return HStack{
            Image(systemName: "chevron.backward")
                .resizable()
                .frame(width: 13, height: 20)
                .padding(.trailing,10)
            Text("lisaa_land")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            Menu {
                Button(action: {}){Text("Ayarlar")}
                Button(action: {}){Text("Çıkış")}
            } label: {
                Image(systemName: "text.justify.leading")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.black.opacity(0.7))
            }
        }.padding(.horizontal)
            .padding(.top)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
