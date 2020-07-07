##############################################
# Date Last Modified: 06/07/2020
# Author: Pedro Puntel
# Email: pedro.puntel@gmail.com
# Topic: R For Data Science - Reference Script
# Encoding: UTF-8
##############################################

############################################
# Chapter I: Data Visualization with ggplot2
############################################

# The tidyverse package coveniently loads a bunch of other packages
library("tidyverse")

# Basic ggplot2 scatterplot
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy), size=2.5, color="black") +
  ggtitle("MPG Dataset - displ x hwy") +
  labs(x="\nEngine Size (liters) \n", y="\nFuel Effciency (Miles per Gallon - Highway)\n")

# The values on the previous scatterplot were rounded, so the points appear
# on a grid and many values overlap with each other (overplotting). To prevent
# this, the use of 'postion = jitter' adds an amount of random noise to the data,
# thus spreading out the points a bit more
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy), size=2.5, color="black", position="jitter") +
  ggtitle("MPG Dataset - displ x hwy (jittered)") +
  labs(x="\nEngine Size (liters) \n", y="\nFuel Effciency (Miles per Gallon - Highway)\n")

# Same scatterplot, now with color mapped to car class
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy, color=class), size=2.5) +
  ggtitle("MPG Dataset - displ x hwy, colored by class") +
  labs(x="\nEngine Size (liters) \n", y="\nFuel Effciency (Miles per Gallon - Highway)\n")

# You can also map an aesthetic to another categorical variable
# Returns a warning stating that the shape aesthetic only maps up to 6 classes
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy, shape=class), size=2.5, color="black") +
  ggtitle("MPG Dataset - displ x hwy, shape by class") +
  labs(x="\nEngine Size (liters) \n", y="\nFuel Effciency (Miles per Gallon - Highway)\n")

# Facets are a quick way to split plots according to classes of a categorical variable
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy), size=2.5, color="black") +
  facet_wrap(~ class, nrow=2) +
  ggtitle("MPG Dataset - displ x hwy, facet by class") +
  labs(x="\nEngine Size (liters) \n", y="\nFuel Effciency (Miles per Gallon - Highway)\n")

# You may also map specific variables to the X and Y axis in facets
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy), size=2.5, color="black") +
  facet_grid(drv ~ cyl) +
  ggtitle("MPG Dataset - dipsl x hwy, facet by drv and cyl") +
  labs(x="\nEngine Size (Liters) \n", y="\nFuel Effciency (Miles per Gallon - Highway)\n")

# The geom_smooth() geometric "fits" an reference line to the data
# ?geom_smooth
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, color=drv), size=2.5) +
  geom_smooth(mapping=aes(x=displ, y=hwy, linetype=drv), color="black", se=T, lwd=1.1) +
  ggtitle("MPG Dataset - dipsl x hwy, colored by drv") +
  labs(x="\nEngine Size (liters) \n", y="\nFuel Effciency (Miles/Gallon on Highway)\n")

# Specifying the mappings in the ggplot "header" minimizes the risk of messing up with
# the mappings on each geometric object
ggplot(data=mpg, mapping=aes(x=displ, y=hwy, color=drv))+
  geom_point(size=2.5) +
  geom_smooth(color="black", se=T, lwd=1.1) +
  ggtitle("MPG Dataset - dpsly x hwy, colored by drv") +
  labs(x="\nEngine Size (liters) \n", y="\nFuel Effciency (Miles/Gallon on Highway)\n")

# However we can use the same ideia to map specific data/aesthetics to an geometric
# object since this will override the global data/aesthetics provided in the "header"
ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data=filter(mpg, class=="subcompact"), se=F, color="black") +
  ggtitle("MPG Dataset - dipsl x hwy, colored by class, smoothed by subcompact") +
  labs(x="\nEngine Size (liters) \n", y="\nFuel Effciency (Miles/Gallon on Highway)\n")

# Simple barchart using the diamonds data set
ggplot(data=diamonds) +
  geom_bar(mapping=aes(x=cut), color="grey") +
  ggtitle("Diamonds Dataset - Distribution by cut") +
  labs(x="\ncut\n", y="\nFrequency\n")

# Same plot, swaps geometric object by stat_count
ggplot(data=diamonds) +
  stat_count(mapping=aes(x=cut), color="grey") +
  ggtitle("Diamonds Dataset - Distribution by cut (i was made with 'stat_count')") +
  labs(x="\ncut\n", y="\nFrequency\n")

# You can color bar chart using either 'color' or 'fill' aesthetics, though the latter
# is preffered
ggplot(data=diamonds) +
  geom_bar(mapping=aes(x=cut, color=cut)) +
  ggtitle("Diamonds Dataset - Distribution by cut") +
  labs(x="\ncut\n", y="\nFrequency\n")

ggplot(data=diamonds) +
  geom_bar(mapping=aes(x=cut, fill=cut)) +
  ggtitle("Diamonds Dataset - Distribution by cut (This is better!!)") +
  labs(x="\ncut\n", y="\nFrequency\n")

# When you map the 'fill' aesthetics to another categorial variable, the bars are
# automatically stacked
ggplot(data=diamonds) +
  geom_bar(mapping=aes(x=cut, fill=clarity)) +
  ggtitle("Diamonds Dataset - Distribution by cut and clarity") +
  labs(x="\ncut\n", y="\nFrequency\n")

# The stacking is performed by the 'position' argument which can be one of three
# options: 'identity', 'fill' or 'dodge'. Using position = identity is useless, so
# it won't be shown here
ggplot(data=diamonds) +
  geom_bar(mapping=aes(x=cut, fill=clarity), position="fill") +
  ggtitle("Diamonds Dataset - Proportion by cut and clarity") +
  labs(x="\ncut\n", y="\nProportion\n")

ggplot(data=diamonds) +
  geom_bar(mapping=aes(x=cut, fill=clarity), position="dodge") +
  ggtitle("Diamonds Dataset - Proportion by cut and clarity") +
  labs(x="\ncut\n", y="\nFrequency\n")

# Use 'coord_filp()' to flip the axes on a plot
ggplot(data=mpg, mapping=aes(x=class, y=hwy)) +
  geom_boxplot(color="orange", lwd=0.75) +
  ggtitle("MPG Dataset - Distribution of Fuel Consumption by class") +
  labs(y="\nFuel Consumption (Miles per Gallon - Highway)\n", x="\nVehicle Class\n")

ggplot(data=mpg, mapping=aes(x=class, y=hwy)) +
  geom_boxplot(color="orange", lwd=0.75) +
  ggtitle("MPG Dataset - Distribution of Fuel Consumption by class") +
  labs(y="\nFuel Consumption (Miles per Gallon - Highway)\n", x="\nVehicle Class") +
  coord_flip()





  







