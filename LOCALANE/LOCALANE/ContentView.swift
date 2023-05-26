//
//  ContentView.swift
//  LOCALANE
//
//  Created by Catherine Candice on 26/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ContentView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var x: CGFloat = 0
    @State var count: CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    
    // Location places (sorted in cards)
    @State var data = [
        Card(id: 0, img: "Astha8", name: "📍ASTHA DISTRICT 8", sidenote: "Remember having a deep random talk with your family🥰", show: false),
        Card(id: 1, img: "BundaranHI", name: "📍BUNDARAN HI", sidenote: "Remember of your stupidity cuz you got off at the wrong station🤡", show: false),
        Card(id: 2, img: "HypePark", name: "📍HYDE PARK", sidenote: "Remember everything there were so iconic😱 Like pet park, dining area, etc.", show: false),
        Card(id: 3, img: "PasMod", name: "📍PASMOD INTERMODA", sidenote: "Remember you would always take this picturesque sunset😍", show: false),
        Card(id: 4, img: "PIK2", name: "📍LA RIVIERA", sidenote: "Remember to revisit Krabby n Patty✨", show: false),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack(spacing: 15) {
                    ForEach(data) { i in
                        VStack {
                            // Placement for carousel of places to be displayed on screen
                            CardView(data: i)
                                .offset(x: self.x)
                                .highPriorityGesture(DragGesture()
                                    .onChanged({ (value) in
                                        if value.translation.width > 0 {
                                            self.x = value.location.x
                                        } else {
                                            self.x = value.location.x - self.screen
                                        }
                                        if value.translation.width > 0 {
                                            if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != self.getMid() {
                                                self.count += 1
                                                self.updateHeight(value: Int(self.count))
                                                self.x = (self.screen + 15) * self.count
                                            }
                                            else {
                                                self.x = (self.screen  + 15) * self.count
                                            }
                                        }
                                        
                                        
                                    })
                                        .onEnded({ (value) in
                                            if value.translation.width > 0 {
                                                if value.translation.width > ((self.screen - 80) / 2) && -Int(self.count) != self.getMid() {
                                                    self.count -= 1
                                                    self.updateHeight(value: Int(self.count))
                                                    self.x = (self.screen + 15) * self.count
                                                } else {
                                                    self.x = (self.screen + 15) * self.count
                                                }
                                            }
                                            else {
                                                if -value.translation.width > ((self.screen - 80) / 2) && -Int(self.count) != self.getMid() {
                                                    self.count -= 1
                                                    self.updateHeight(value: Int(self.count))
                                                    self.x = (self.screen + 15) * self.count
                                                } else {
                                                    self.x = (self.screen + 15) * self.count
                                                }
                                            }
                                        })
                            )
                        }
                        
                    }
                }
                
                Spacer()
            }
            .background(Color.gray.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("LOCALANE")
                .foregroundColor(.black)
            .animation(.spring())
            .onAppear {
                self.data[self.getMid()].show = true
            }
        }
    }
    
    // set the display place in the screen (focused on the place when sliding the carousel)
    func getMid() -> Int {
        return data.count / 2
    }
    
    func updateHeight(value: Int) {
        var id: Int
        
        if value < 0 {
            id = -value + getMid()
        } else {
            id = getMid() - value
        }
        
        for i in 0..<data.count {
            data[i].show = false
        }
        data[id].show = true
    }
}

struct CardView: View {
    @State var buttonIsClicked = false
    var data: Card
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Image(data.img)
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 30, height: data.show ? 400 : 250)
            
            Text(data.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20))
                .frame(width: UIScreen.main.bounds.width - 30, height: data.show ? 20 : 20)
            
            Text(data.sidenote)
                .font(.body)
                .italic()
                .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20))
                .frame(width: UIScreen.main.bounds.width - 30, height: data.show ? 100 : 20)
            
            Divider()
            
            // See more detailed informations
            Button {
                buttonIsClicked = true
            } label: {
                Text("Take Me Back").foregroundColor(.blue)
            }.frame(width: UIScreen.main.bounds.width - 30, height: data.show ? 100 : 20)
            NavigationLink("", destination: DetailView(), isActive: $buttonIsClicked)
        }
        .background(Color.white)
        .cornerRadius(25)
    }
}

struct Card: Identifiable {
    var id: Int
    var img: String
    var name: String
    var sidenote: String
    var show: Bool
}
