//
//  MainView.swift
//  Invest me
//
//  Created by Ismatillo Marufkhonov on 29/05/22.
//

import SwiftUI

struct MainView: View {
    var array = ["All","Bussines","Technology","Social"]
    var body: some View {
        VStack
        {
            self.scroll
            
            self.title
            
            Spacer()
        }
    }
}




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


extension MainView
{
    var scroll: some View
    {
        ScrollView(.horizontal)
        {
            HStack
            {
                ForEach(0..<array.count, id: \.self) {index in
                    Button(action: {
                        
                    }) {
                        Text(array[index])
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }
    
    
    
    var title: some View
    {
        Text("From Peaople To People")
            .font(.system(size: 20))
            .padding(.top)
    }
}
