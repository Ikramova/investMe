//
//  Verification.swift
//  Invest me
//
//  Created by Ismatillo Marufkhonov on 29/05/22.
//

import SwiftUI

struct Verification: View {
    
    @State var someView = false
    @State var investorView = false
    
    var body: some View {
        VStack
        {
            Text("Who are you?")
                .font(.largeTitle).padding(.top, 40)
            
            if self.someView
            {
                NavigationLink(destination: SomeView(), isActive: self.$someView) {}
            }
            
            if self.investorView
            {
                NavigationLink(destination: InvestorView(), isActive: self.$investorView) {}
            }
            
            Image("appIcon")
                .resizable()
                .frame(width: 200, height: 200)
            
            Button(action: {
                self.someView = true
            }) {
                Text("Person")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width / 1.5,
                           height: 70)
                    .background(.red)
                    .clipShape(Capsule())
                
            }
            
            .padding()
            
            Button(action: {
              
            }) {
                Text("Specialty")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width / 1.5,
                           height: 70)
                    .background(.green)
                    .clipShape(Capsule())
                
            }
        
            
            Spacer()
            
            .navigationTitle("Welcome!")
        }
    }
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        Verification()
    }
}
