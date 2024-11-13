##########Geospatial Map ######################


library(leaflet)


usa_data <- read.csv("C:/Users/Amit/Downloads/cancervolume.csv")
usa_data <- usa_data[-c(1:100), ]
colnames(usa_data) <- c("Year", "County", "Hospital", "Surgery", "Number_of_Cases", "LONGITUDE", "LATITUDE")
usa_data <- usa_data[complete.cases(usa_data$LATITUDE, usa_data$LONGITUDE), ]
map <- leaflet(data = usa_data) %>%
  addTiles() %>%
  setView(lng = -119.4179, lat = 36.7783, zoom = 6)


more_cases_color <- "blue"
fewer_cases_color <- "lightblue"


map <- addCircleMarkers(map,
                        lng = ~LONGITUDE,
                        lat = ~LATITUDE,
                        radius = 5,
                        color = ifelse(usa_data$Number_of_Cases >= median(usa_data$Number_of_Cases), 
                                       more_cases_color, fewer_cases_color),
                        popup = ~paste("Hospital: ", iconv(Hospital, to = "UTF-8"), "<br>",
                                       "Surgery: ", iconv(Surgery, to = "UTF-8"), "<br>",
                                       "# of Cases: ", Number_of_Cases))


map



##############################################################
##############################################################


library(dplyr)
library(ggplot2)


surgery_data <- read.csv("C:/Users/Amit/Downloads/cancervolume1.csv")
surgery_data <- surgery_data[-c(1:100), ]


top_20_counties <- surgery_data %>%
  group_by(County) %>%
  summarise(total_cases = sum(number_of_cases)) %>%
  arrange(desc(total_cases)) %>%
  slice(1:20)

ggplot(top_20_counties, aes(x = reorder(County, total_cases), y = total_cases)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Top 20 Counties by Surgery Volume",
       x = "County",
       y = "Number of Cases") +
  theme(axis.text.x = element_text( hjust = 1)) +
  coord_flip()