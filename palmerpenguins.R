# Analyzing and Visualizing Palmerpenguins Data


# Installation of Palmerpenguins and Tidyverse

install.packages("palmerpenguins")
install.packages("tidyverse")

library(palmerpenguins)
library(tidyverse)

head(penguins)

# Use summary(), str(), glimpse() and colnames() functions to summarize the data

summary(penguins)
str(penguins)
glimpse(penguins)
colnames(penguins)

# Let’s create a new dataframe by arranging the data by flipper length in a descending order, 
# this way we can preview the relationships between columns

flipper_length_arrange <- arrange(penguins, desc(flipper_length_mm))
View(flipper_length_arrange)

# Let’s say we only want to see body mass for each species and islands by using pipe

islands_penguins <- penguins %>% select(species, island, body_mass_g)
View(islands_penguins)

# Ratio of flipper length to body mass in order from smallest to largest with a new dataframe

flipper_length_percentage <- mutate(penguins, flipper_length_percentage = flipper_length_mm / body_mass_g * 100) %>% arrange(flipper_length_percentage)
View(flipper_length_percentage)

# If we only want to see the bill depths between 13.6 and 19.5 for the island of Biscoe in descending order

Only_Biscoe <- filter(penguins, penguins$island=="Biscoe") %>% arrange(desc(bill_depth_mm)) %>% select(bill_depth_mm, island) %>% filter(between(bill_depth_mm,13.6,19.5))
View(Only_Biscoe)


# Visualisation by Using Ggplot2


# First we need to install the ggplot2 library

library(ggplot2)

# Let's show the relationship between body mass and flipper length 

ggplot(data = penguins) +
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g,color=species))+
  labs(title =  "Body mass and flipper length")

# Let’s create graphs showing flipper lengths for each species separately by using facet_wrap function

ggplot(data = penguins) +
  geom_bar(mapping = aes(x=flipper_length_mm,fill=species)) + facet_wrap(~species)

# We can also use geom_smooth to show relationship between body mass and flipper length

ggplot(data = penguins) +
  geom_smooth(mapping = aes(x=flipper_length_mm, y=body_mass_g,color=species))

# Plus, we can combine both together

ggplot(data = penguins) +
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g,color=species)) +
  geom_smooth(mapping = aes(x=flipper_length_mm, y=body_mass_g,color=species)) +
  labs(title =  "Body mass and flipper length",subtitle="Relationship between body mass and flipper length")

# After combining geom_point and geom_smooth together, we can view all species separately by using facet_wrap

ggplot(data = penguins) + geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g,color=species)) + 
  geom_smooth(mapping = aes(x=flipper_length_mm, y=body_mass_g,color=species)) +
  labs(title =  "Body mass and flipper length",subtitle="Relationship between body mass and flipper length") + 
  facet_wrap(~species)

# If we want to see how many species there are on each year

ggplot(data = penguins) +
  geom_bar(mapping = aes(x=year,fill=species))+
  labs(title = "Species for each year") +
  facet_wrap(~species)
