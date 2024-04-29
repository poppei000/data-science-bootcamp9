game <- function() {
        username <- readline("What's your name: ")
        cat("Hello!",username,"\n")
        cat("Welcome to the 'rock' 'paper' 'scissors' game!\n")
        cat("Nice to meet you, My name is Lisa!\n")
        cat("Let's play game!\n")
        cat("\n")

        hands <- c("rock","paper","scissors")

        user_score <- 0
        bot_score <- 0
        count <- 0

            while((user_score != 2 ) & (bot_score != 2 )){
                flush.console()

                bot_hands <- sample(hands,1)
                user_hands <- readline("choose your hands (rock, paper, scissors): ")
                cat("your hand is",user_hands,"bot hand is",bot_hands,"\n")

                if((user_hands == "rock" & bot_hands == "scissors") |
                (user_hands == "paper" & bot_hands == "rock") |
                (user_hands == "scissors" & bot_hands == "paper")){
                        user_score = user_score + 1
                        cat("you win!\n")
                }

                else if((user_hands == "rock" & bot_hands == "rock") |
                        (user_hands == "paper" & bot_hands == "paper") |
                        (user_hands == "scissors" & bot_hands == "scissors")){
                        cat("you draw!\n")
                }

                else{
                        bot_score = bot_score + 1
                        cat("you lose!\n")
                }

                cat("you score is",user_score,"bot score is",bot_score,"\n")
                cat("\n")
                cat("\n")
            }

        cat("game over!\n")
        cat("\n")
        if(user_score == 2) {
            cat("Congratulations, you win!\n")
        } else {
            cat("I'm sorry you lost.\n")
        }
}

game()
