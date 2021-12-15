//
//  UIkitScene.swift
//  UIKIT+swiftui
//
//  Created by hosam on 15/12/2021.
//

import SwiftUI

struct UIkitScene: View {
    var action:()->()
    var timeAction:()->()
@State var endDate=""
    var notificationChanged = NotificationCenter.default.publisher(for: Notification.Name(rawValue: "sss"))

    var body: some View {
        VStack {
            
            HStack {
                
                Button(action: {withAnimation{action()}}, label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                        .font(.system(size: 50))
                })
                Spacer()

            }
            .padding(.horizontal)
            .padding(.top,20)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                        withAnimation{  timeAction()}
                        
                    } label: {
                        
                            
                            HStack {
                                
                                Text(LocalizedStringKey(getTimse()) )
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray.opacity(0.8))
                                
                                Spacer()
                                
                                //                    Button(action: {withAnimation{
                                //                        timeAction()
                                ////                        vm.isShpwTransaction=true
                                //                    }}, label: {
                                Image("time")
                                
                                //                    })
                                
                            }
                            .padding(.horizontal)
                            
                            .frame(width:220,height:40)
                    
                    
                    
                }
                Spacer()
            }
            Spacer()

    }
        .onReceive(notificationChanged) { note in
            let s = note.userInfo?["key"] as? String ?? ""
            self.endDate=s
            
        }
        
    }
        
        func getTimse() -> String {
            return endDate == "" ? "Time" : endDate
        }
}

struct UIkitScene_Previews: PreviewProvider {
    static var previews: some View {
        UIkitScene(action: {}, timeAction: {})
    }
}
