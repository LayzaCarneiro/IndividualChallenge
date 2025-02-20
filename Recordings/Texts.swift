//
//  Words.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import Foundation

let stories: [String: String] = [
    "Down the Tracks": """
    The train pulled away just after Todd stepped onto it. He was traveling to Chicago for a business meeting. The meeting was on Thursday and he wanted to explore the city for a few days before the meeting.

    He pulled out his travel map and started to make plans. "I hope I have enough time to visit all of the sites I want to see" he thought.
    """,
    
    "Store Catastrophe": """
    While he was picking out his favorite vegetables, Conrad started to hear the loudest screaming. He wondered what happened. He walked over to the ice cream aisle and found what was causing the noise.

    A little boy had dropped his ice cream cone on the floor and was very sad and upset. "Wow" thought Conrad, "dropping your ice cream isn't that big of a problem. I'm glad he isn't hurt."
    """,
    
    "Day at the Beach": """
    Lexie jumped into the wave and was immediately immersed in the water. She stood up and came out of the water. "I love the water, I love the waves and I love the sand," she said.

    Her family was visiting the beach for 1 whole week and this was their first day. She looked forward to every minute she could spend swimming on the beach.
    """,
    
    "The Right Ingredients": """
    When she got home from school Gracie wanted her favorite treat, chocolate chip cookies. She mixed all of the ingredients together, put the cookie dough on the sheet and put the sheet in the oven.

    After they were finished baking she pulled them out of the oven. Even though they were still hot she put a whole cookie right in her mouth. She quickly spit it out because it tasted really salty. "I guess I read the recipe wrong," she said.
    """,
    
    "All On Account of Rain": """
    Katie had been waiting for 5 months to see the movie, and now she was late. The rain was pouring so hard that her mother had to drive slower than usual.

    When they finally parked in the theater parking lot, Katie and her mom opened their umbrellas, stepped out of the car, and ran up to the theater doors. On the doors the sign read "Closed, No Power". The storm had caused a power outage.
    """,
    
    "Scared Stiff": """
    Zander was proud of his new costume. He was excited to wear it for the play on Friday night. The bones looked like a real skeleton, the eyes were beady and red, and the claws were long and sharp.

    He thought it would be fun to scare his Mom, so he walked quietly down the hall toward the kitchen. Suddenly, he screamed "Ahhhhhhh!" He saw his reflection in the mirror and forgot he was wearing his costume.
    """,
    
    "Close Encounter": """
    It was a long hike down the trail to reach the spring, but they needed more water for their group. Gabe and BJ were thirsty too. They were looking forward to a nice refreshing drink.

    As they walked they came to a clearing only to see a very large moose standing 50 feet away from them. "Be quiet and walk slowly," said Gabe. When they could no longer see the moose, BJ said "Phew that was close."
    """,
    
    "Just In Time": """
    The score was tied with only seconds left. Kyle passed the ball to Kenny who dribbled it down the court. Instantly, three defenders swarmed around Kenny and started swiping at the ball.

    The clock was winding down, 8...7...6. Kenny found an opening and passed to Tenley. She shot and easily made the basket just as the buzzer went off to end the game.
    """,
    
    "Camp Counselors": """
    She arrived at camp after days of driving across most of the United States. Megan was excited to meet the campers and counselors. She was greeted by counselors from over 30 different countries.

    She was taken on a tour of the camp and saw where she would be working; even though the campers had not arrived yet, Megan knew that this would be a summer to remember.
    """,
    
    "At the Speed of Light": """
    It took 2 & 1/2 hours of waiting in line to sit at the front of the fastest roller coaster in the country.

    Luke and Hollie were nervous.

    The roller coaster was reported to reach a top speed of 120 mph. They fastened their seat belts and watched the lights, Yellow... Yellow... Yellow... Green! The car shot forward. Luke and Hollie let out cheers of excitement, while their cheeks flapped in the wind.

    "Woohoo!" they exclaimed after the car had come to a stop, "we should definitely do that again!"
    """
]

func randomStory() -> (title: String, text: String)? {
    if let (key, value) = stories.randomElement() {
        return (title: key, text: value)
    }
    return nil
}


//// Exemplo de uso
//if let story = randomStory() {
//    print("Title: \(story.title)\n")
//    print("Story: \(story.text)")
//}
