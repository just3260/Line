//import App
//
//try app(.detect()).run()

// ============================================================


import Vapor
import LineBot
import Jobs

let accessToken = "uNha8IMsykz/XoGmQhuWyvqVc6Ta36vi1yVCx16jH6Dfwu17iaJrQXZqipY8fgvMrxrxvtNcRKpVpmP/XyUtewpgpm40oQFxPSbaZDUbqb+mKSydSvjDgtbBxnKD+w/VrLugyzamDrBmgG7lw4lV/wdB04t89/1O/w1cDnyilFU="
let channelSecret = "2350b45a5aab2f3fd5767dcc5ed4e749"
var selfID: String = "U29629efc0ba592585e9130f618f0c0c7"


let drop = try Droplet()

let bot = LineBot(accessToken: accessToken, channelSecret: channelSecret)


// 設置一個 job 每 10 秒 say Hello !!
let helloJob = Jobs.add(interval: 10.seconds, autoStart: false) {
    if selfID != nil {
        bot.push(userId: selfID, messages: [.text(text: "👋 Hello !!!")])
    }
}



drop.get("hello", String.parameter) {
    req -> String in
    let name = try req.parameters.next(String.self)
    return "Hello, \(name)!"
}


drop.get("hello", String.parameter) {
    req -> String in
    let name = try req.parameters.next(String.self)
    return "Hello, \(name)!"
}


drop.post("callback") { request in
    
    guard let content = request.body.bytes?.makeString() else {
        return Response(status: .badRequest)
    }
    
    guard let signature = request.headers["X-Line-Signature"] else {
        return Response(status: .badRequest)
    }
    
    //    guard bot.validateSignature(content: content, signature: signature) else {
    //        return Response(status: .badRequest)
    //    }
    
    guard let events = bot.parseEventsFrom(requestBody: content) else {
        return Response(status: .badRequest)
    }
    
    for event in events {
        
        switch event {
        case .message(let message):
            let replyToken = message.replyToken
            
            // 單一訊息
            switch message.message {
            case .text(let content):
                
                if content.text == "startJob" {
                    helloJob.start()
                } else if content.text == "stopJob" {
                    helloJob.stop()
                } else if content.text == "setting user" {
                    let user = message.source.userId
                    bot.reply(token: replyToken, messages: [.text(text: "已設定 ID：\(user)")])
                }
                
//                bot.reply(token: replyToken, messages: [.text(text: content.text)])
            case _:
                break
            }
            
        case _:
            break
        }
        
    }
    
    return Response(status: .ok)
}






try drop.run()




