//import App
//
//try app(.detect()).run()





// ============================================================

import Vapor
import Fluent
import LineBot


let accessToken = "uNha8IMsykz/XoGmQhuWyvqVc6Ta36vi1yVCx16jH6Dfwu17iaJrQXZqipY8fgvMrxrxvtNcRKpVpmP/XyUtewpgpm40oQFxPSbaZDUbqb+mKSydSvjDgtbBxnKD+w/VrLugyzamDrBmgG7lw4lV/wdB04t89/1O/w1cDnyilFU="
let channelSecret = "2350b45a5aab2f3fd5767dcc5ed4e749"


let drop = try Droplet()


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
    let bot = LineBot(accessToken: accessToken, channelSecret: channelSecret)
    
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
            switch message.message {
            case .text(let content):
                bot.reply(token: replyToken, messages: [.text(text: content.text)])
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
