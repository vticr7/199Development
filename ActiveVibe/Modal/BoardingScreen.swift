import SwiftUI

struct BoardingScreen: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
}


let title = "199Development"


let description = "Mindbreath bridges the gap between traditional mindfulness practices and cutting-edge biofeedback technology."
let description_2 = "Our biofeedback-powered Mindbreath system tailors its approach to your unique needs, helping you achieve holistic well-being."
let description_3 = "We combine the wisdom of time-tested practices with the power of biofeedback, positioning Mindbreath at the forefront of the health-biofeedback revolution."
let description_4 = "Mindbreath empowers you to harness the power of biofeedback to enhance your well-being and reach your full potential."


var boardingScreens: [BoardingScreen] = [
    BoardingScreen(image: "screen1", title: title, description: description),
    BoardingScreen(image: "screen2", title: title, description: description_2),
    BoardingScreen(image: "screen3", title: title, description: description_3),
    BoardingScreen(image: "screen4", title: title, description: description_4),
]
