# this is R programming
print('hello world')

print("this is a second line")

library(dplyr)

df <- read_csv("filename.csv")

df %>%
  filter(col > 100)

# update dplyr function
df2 <- df %>%
  select(1:10) %>%
  filter(country == "Thailand") %>%
  arrange(-income)

# plot new histogram
library(ggplot2)
ggplot(df2,aes(income)) +
  geom_histogram()
