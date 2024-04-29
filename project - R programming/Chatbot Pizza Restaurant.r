is_numeric <- function(x) {
  suppressWarnings(!is.na(as.numeric(x)))
}

chatbot <- function(menus) {
    print("Welcome to Pizzy Pizza!")
    print("My name is Lisa!")
    print("I'm here to serve you. Please choose the menu that you want.")
    cat("\n")
    print(menus)
    flush.console()

    id_list <- c()
    amount_list <- c()
    total_price <- 0

    while(TRUE){
        cat("\n")
        flush.console()
        cat("Please choose you menu ( 1 -",length(menus$id),")")
        flush.console()
        order <- readline(":")

        if(is_numeric(order)){
            order = as.integer(order)

            if(order %in% menus$id){
                cat("How much",menus$menu[order],"do you want")
                flush.console()
                amount <- readline(":")

                if(is_numeric(amount)){
                    amount = as.integer(amount)
                    amount_list <- c(amount_list,amount)
                    id_list <- c(id_list,order)
                    while(TRUE){
                        choice <- tolower(readline("You want anything else (yes/no):"))

                        if(choice %in% c("yes","no")){
                            break
                        }else {
                            print("Don't understand 404")
                            flush.console()
                        }
                    }

                    if(choice == "no"){
                        break
                    }
                }else {
                    print("Amount is in valid")
                }
            } else {
                print("Menu not found 404")
            }
        }else {
            print("Please type number!")
        }
        flush.console()
    }

    cat("\n")
    flush.console()

    while(TRUE){
        choice <- tolower(readline("You want to eat here or takeaway :"))
        if(choice %in% c("here","takeaway")){
            break
        }else {
            print("Don't understand 404")
            flush.console()
        }
    }

    if(choice == "takeaway"){
        print("Please wait a moment.")

    }

    cat("\n")
    flush.console()

    for(i in seq_along(id_list)){
        price <- (menus$price[id_list[i]]*amount_list[i])
        total_price = total_price + price
        cat("Your order",amount_list[i],menus$menu[id_list[i]],"price is:",price,"\n")
        flush.console()
    }

    cat("\n")
    flush.console()

    cat("Total price is:",total_price,"\n")
    flush.console()

    print("Thanks for using our service.")

    }

menus <- data.frame(
    id = c(1:6),
    menu = c("Crispy Chicken", "Pastrami", "Pineapple Shrimp", "Meat Lover", "Fruit Deluxe","Cheese Lover"),
    price = c(200, 150, 200, 300, 150, 250)
)

chatbot(menus)
