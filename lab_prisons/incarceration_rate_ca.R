library(tmap)
library(sf)
library(tigris)
library(readr)


#Get Spatial Data for California Counties
#this is the county shapefiles
options(tigris_class = "sf")
ca_counties_spatial <- counties(state = "CA", cb = TRUE) # cb = TRUE for a cartographic boundary (simpler shapes)


# Read the CSV file into an R data frame
## find it here https://github.com/mrjdl/635.r/blob/main/prison_data/prison.csv

prison_data <- read_csv("prison.csv")

# View the first few rows of the data frame
head(prison_data)

# Assuming your data is in an R dataframe called prison_data, and you're merging by county name
# Ensure the county names match exactly between datasets, adjusting as necessary
merged_data <- merge(ca_counties_spatial, prison_data, by.x = "NAME", by.y = "California counties")

##map
tmap_mode("view")

tm_shape(merged_data) +
  tm_polygons("Imprisonment rate per 100,000", title = "Imprisonment Rate") +
  tm_layout(main.title = "Imprisonment Rate per 100,000 Population in California Counties (2020)",
            main.title.position = "center",
            legend.position = c("left", "bottom"))

