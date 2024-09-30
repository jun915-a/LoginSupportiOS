//
//  SecondScreen.swift
//  Test
//
//  Created by junpei arai on 2024/09/25.
//

import SwiftUI


struct CustomDialog: View {
    @Binding var showEditDialog: Bool // 親ビューから状態をバインド
    @State var nameState: String = ""
    @State var idState: String = ""
    @State var passState: String = ""
    @State var memoState: String = ""
    
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.4) // 半透明の背景
                .edgesIgnoringSafeArea(.all) // 画面全体を覆う
            
            VStack() {
                Text("アイテム編集")
                dialogNameItem(title:"アイテム名")
                dialogIdItem(title:"ユーザーID")
                dialogPassItem(title:"パスワード")
                dialogMemoItem(title:"メモ")
                
                HStack {
                    Button("Cancel") {
                        showEditDialog = false // ダイアログを閉じる
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("OK") {
                        // OKボタンのアクション
                        let itemList = ContentView.Item(name: nameState,id:idState,pass: passState,memo: memoState)
                        // JSONエンコードしてUserDefaultsに保存
                        if let encodedData = try? JSONEncoder().encode(itemList) {
                            UserDefaults.standard.set(encodedData, forKey: "itemList")
                        } else {
                            print("Failed to encode item list.")
                        }
                        showEditDialog = false // ダイアログを閉じる
                        
                        
                    }
                    .padding()
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .frame(maxWidth: .infinity) // ボタンを等幅に
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 20) // 影を追加
            .padding(40) // 画面の端からの余白
        }
    }
    
    
    func dialogNameItem(title:String) -> some View {
        VStack{
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading) // 左寄せの設定
            TextField(title, text: $nameState)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // 丸みのあるボーダースタイル
                .padding(.bottom,16)
        }
    }
    
    func dialogIdItem(title:String) -> some View {
        VStack{
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading) // 左寄せの設定
            TextField(title, text: $idState)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // 丸みのあるボーダースタイル
                .padding(.bottom,16)
        }
    }
    func dialogPassItem(title:String) -> some View {
        VStack{
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading) // 左寄せの設定
            TextField(title, text: $passState)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // 丸みのあるボーダースタイル
                .padding(.bottom,16)
        }
    }
    func dialogMemoItem(title:String) -> some View {
        VStack{
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading) // 左寄せの設定
            TextField(title, text: $memoState)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // 丸みのあるボーダースタイル
                .padding(.bottom,16)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
