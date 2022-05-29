//
//  PurchasingView.swift
//  Baby App
//
//  Created by Shaxzod on 15/11/21.
//

import SwiftUI

struct PurchasingView: View {
    
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @Namespace var namespace
    @State var cardNumber = ""
    @State var cardDate = ""
    @State var selectedIndex = 0
    @State var methodSelected = false
    @State var finalCardNumber = ""
    @State var finalExpiredDate = ""
    @State var costSum = "200 000"
    
    let titleColor = Color.blue
    let iconsName = ["payme", "click", "applePay"]
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(spacing:0) {
            
            //MARK: - Nav Bar
            navBar
            
            Divider()
                .padding(.top, 16)
            
            //MARK: - General Views
            VStack(spacing: 32) {
                
                //MARK: - Price Text
                cost
                
                if methodSelected {
                    //MARK: - Card Info
                    cardInfo
                    
                    //MARK: - Selected Payment Method
                    selectedPaymentMethod
                    
                } else {
                    //MARK: - Payment Methods
                    paymentMethods
                }
            }
            .frame(width: width - 48, alignment: .center)
            
            Spacer()
        }
        .frame(width: width, alignment: .center)
        
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension PurchasingView {
    
    private var navBar: some View {
        HStack(spacing: 16) {
            Button {
                if methodSelected  {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        methodSelected = false
                    }
                }
                else {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                
                Image(systemName: "chevron.left")
                    .font(.system(size: 20,weight: .bold))
                    .foregroundColor(Color.blue)
                    .padding()
                    .background(Circle().fill(Color.gray.opacity(0.3)))
            }
            
            Text("Purchasing")
                .font(.system(size: 30))
                .foregroundColor(Color.black)
        }
        .frame(width: width - 48, alignment:.leading)
        .padding(.top, 28)
    }
    
    private var paymentMethods: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Payment Method")
                .fixedSize()
                .matchedGeometryEffect(id: "text", in: namespace)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
            
            //MARK: - Paymen Button
            VStack(spacing: 8) {
                ForEach((0..<iconsName.count), id:\.self) { index in
                    
                    Button {
                        selectedIndex = index
                        withAnimation(.easeInOut(duration: 0.7)) {
                            methodSelected.toggle()
                        }
                        
                    } label: {
                        Image(iconsName[index])
                            .resizable()
                            .scaledToFill()
                            .matchedGeometryEffect(id: "icon\(index)", in: namespace)
                            .frame(width: 80, height: 25)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5) ,lineWidth: 1)
                                
                            )
                        
                    }
                    .matchedGeometryEffect(id: "btn\(index)", in: namespace)
                    
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var selectedPaymentMethod: some View {
        VStack {
            Spacer()
            HStack {
                Text("Payment Method")
                    .fixedSize()
                    .matchedGeometryEffect(id: "text", in: namespace)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        methodSelected.toggle()
                    }
                } label: {
                    Image(iconsName[selectedIndex])
                        .matchedGeometryEffect(id: "icon\(selectedIndex)",
                                               in: namespace)
                }
                
            }
            .frame(maxWidth: .infinity, alignment:.leading)
            .padding(.bottom, 32)
            
            Button {
                let cardNumber = cardNumber.replacingOccurrences(of: " ", with: "")
                let expireDate = cardDate.replacingOccurrences(of: "/", with: "")
                print(cardNumber)
                print(expireDate)
                
            } label: {
                Text("Upgrade")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: width - 48 , height: 60)
                    .background(.blue)
                    .cornerRadius(8)
            }
            .matchedGeometryEffect(id: "btn\(selectedIndex)", in: namespace)
            
        }
    }
    
    private var cost: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Cost")
                .font(.system(size: 20))
                .foregroundColor(.black)
            
            if methodSelected
            {
                TextField("Enter ", text: self.$costSum)
                    .keyboardType(.numberPad)
                    .padding(.bottom, 8)
            } else {
                Text("\(self.costSum) UZS")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                .padding(.trailing, 50)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 32)
    }
    
    private var cardInfo: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Card number")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                .padding(.bottom, 16)
            
            TextField("Card number", text: $cardNumber)
                .keyboardType(.numberPad)
                .padding(.bottom, 8)
                .onChange(of: cardNumber) { newValue in
                    if cardNumber.count <= 19 {
                        cardNumber = modifyCreditCardString(creditCardString: cardNumber)
                         finalCardNumber = cardNumber
                    } else {
                        cardNumber = finalCardNumber
                    }
                }
            
            Divider()
            
            Text("Valid through")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.top, 24)
                .padding(.bottom, 16)
            
            TextField("00 / 00", text: $cardDate)
                .keyboardType(.numberPad)
                .padding(.bottom, 8)
                .onChange(of: cardDate, perform: { newValue in
                    if cardDate.count <= 5 {
                        cardDate = modifyCardExpiredDate(expiretDate: cardDate)
                        finalExpiredDate = cardDate
                    } else {
                        cardDate = finalExpiredDate
                    }
                })
            Divider()
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    // For card number
    func modifyCreditCardString(creditCardString : String) -> String {
            let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
            
            let arrOfCharacters = Array(trimmedString)
            var modifiedCreditCardString = ""
            
            if(arrOfCharacters.count > 0) {
                for i in 0...arrOfCharacters.count - 1 {
                    modifiedCreditCardString.append(arrOfCharacters[i])
                    if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                        modifiedCreditCardString.append(" ")
                    }
                }
            }
            return modifiedCreditCardString
        }
    // For card expoertion date
        func modifyCardExpiredDate(expiretDate : String) -> String {
            let trimmedString = expiretDate.replacingOccurrences(of: "/", with: "")
            
            let arrOfCharacters = Array(trimmedString)
            var modifiedExpiretDate = ""
            
            if(arrOfCharacters.count > 0) {
                for i in 0...arrOfCharacters.count - 1 {
                    modifiedExpiretDate.append(arrOfCharacters[i])
                    if((i+1) % 2 == 0 && i+1 != arrOfCharacters.count){
                        modifiedExpiretDate.append("/")
                    }
                }
            }
            return modifiedExpiretDate
        }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasingView()
    }
}
