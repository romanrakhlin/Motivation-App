//
//  OnboardingStepView.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 05.11.2021.
//

import SwiftUI

struct EachOnboardingView: View {
    
    var data: OnboardingDataModel
    var count: Int

    @Binding var typeOf: String
    @Binding var howMany: Int
    @Binding var from: Int
    @Binding var to: Int
    let arrayOfTimes: [String]
    
    var body: some View {
        VStack {
            if count == 0 {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(data.heading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 44, weight: .bold, design: .rounded))
                        Text(data.text)
                            .foregroundColor(Color.black)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                    }
                    .padding(.horizontal, 20)
                    
                    Image(data.background)
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        Spacer()
                    }
                    .background(Color(hex: "2A4F64"))
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                .background(Color.white)
            } else if count == 1 {
                VStack(alignment: .center, spacing: 40) {
                    VStack(alignment: .leading) {
                        Text(data.heading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        
                        Text(data.text)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .light, design: .rounded))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Type of")
                                .foregroundColor(Color.black)
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                            
                            Spacer()
                            
                            Menu {
                                Picker("picker", selection: $typeOf, content: {
                                    Text("Motivation").background(Color.white).tag("Motivation")
                                    Text("Time").tag("Time")
                                    Text("Wisdom").tag("Wisdom")
                                    Text("Inspiration").tag("Inspiration")
                                    Text("Love").tag("Love")
                                    Text("Success").tag("Success")
                                    Text("Happiness").tag("Happiness")
                                    Text("Life Lessons").tag("Life Lessons")
                                    Text("Spirituality").tag("Spirituality")
                                    Text("Philosophy").tag("Philosophy")
                                })
                                .labelsHidden()
                                .pickerStyle(InlinePickerStyle())
                                .foregroundColor(Color.black)

                            } label: {
                                Text(typeOf)
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.black)
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("How many")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    if howMany != 1 {
                                        howMany -= 1
                                    }
                                }) {
                                    Image(systemName: "minus.square")
                                        .padding()
                                        .foregroundColor(Color.black)
                                }
                                
                                Text("\(howMany)X")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.black)
                                
                                Button(action: {
                                    if howMany != 15 {
                                        howMany += 1
                                    }
                                }) {
                                    Image(systemName: "plus.square")
                                        .padding()
                                        .foregroundColor(Color.black)
                                }
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Starts at")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    if from != 0 {
                                        from -= 1
                                    }
                                }) {
                                    Image(systemName: "minus.square")
                                        .padding()
                                        .foregroundColor(Color.black)
                                }
                                
                                Text(arrayOfTimes[from])
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.black)
                                
                                Button(action: {
                                    if from != arrayOfTimes.count - 1 {
                                        from += 1
                                    }
                                }) {
                                    Image(systemName: "plus.square")
                                        .padding()
                                        .foregroundColor(Color.black)
                                }
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Ends at")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    if to != 1 {
                                        to -= 1
                                    }
                                }) {
                                    Image(systemName: "minus.square")
                                        .padding()
                                        .foregroundColor(Color.black)
                                }
                                
                                Text(arrayOfTimes[to])
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.black)
                                
                                Button(action: {
                                    if to != arrayOfTimes.count - 1 {
                                        to += 1
                                    }
                                }) {
                                    Image(systemName: "plus.square")
                                        .padding()
                                        .foregroundColor(Color.black)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                .background(Color.white)
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    Image(data.background)
                        .resizable()
                        .scaledToFit()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(data.heading)
                            .foregroundColor(Color.black)
                            .font(.system(size: 36, weight: .semibold, design: .rounded))
                        
                        Text(data.text)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .light, design: .rounded))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                .background(Color.white)
                .ignoresSafeArea(.all)
            }
        }
    }
}
