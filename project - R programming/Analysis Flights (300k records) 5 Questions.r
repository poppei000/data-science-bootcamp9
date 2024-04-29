## install package
install.packages(c("tidyverse", "glue", "RSQlite", "RPostgreSQL", "lubridate"))

## load library
library(nycflights13)
library(tidyverse) # dplyr
library(glue)
library(lubridate)

## Data
data("flights")
data("airlines")

## Q1. Airports with the top 10 longest distance between each other.
A1 <- flights %>%
        select(origin, dest, distance) %>%
        mutate(distance = round(distance*1.6),) %>%
        arrange(desc(distance)) %>%
        distinct(.) %>%
        rename("distance (km)" = distance) %>%
        left_join(airports, by = c("origin" = "faa")) %>%
        left_join(airports, by = c("dest" = "faa")) %>%
        select(name.x,name.y,"distance (km)") %>%
        rename("origin" = name.x ) %>%
        rename("destination" = name.y ) %>%
        head(10)

view(A1)

## Q2. Total flight of each carrier.
A2 <- flights %>%
        group_by(carrier) %>%
        summarise(total_flights = n()) %>%
        arrange(carrier) %>%
        left_join(airlines, by="carrier") %>%
        select(name, total_flights)

view(A2)

## Q3. Total flight of each month.
A3 <- flights %>%
        group_by(month = factor(
          month,levels = 1:12, labels = month.name)) %>%
        summarise(total_flights = n()) %>%
        arrange(month)

view(A3)

## Q4. departure airports with the most delay times.
A4 <- flights %>%
        select(origin, dep_delay) %>%
        arrange(desc(dep_delay)) %>%
        distinct(origin,.keep_all = TRUE) %>%
        left_join(airports, by = c("origin" = "faa")) %>%
        select(name, dep_delay) %>%
        rename("delay_time" = dep_delay)

view(A4)

## Q5. Top 10 airlines with the good time performance.
#remark:Negative times represent early departures/arrivals.
A5 <- flights %>%
        mutate(time_performance = dep_delay + arr_delay) %>%
        select(carrier, time_performance) %>%
        arrange(time_performance) %>%
        left_join(airlines, by="carrier") %>%
        select(name,time_performance) %>%
        distinct(name,.keep_all = TRUE) %>%
        head(10)

view(A5)
