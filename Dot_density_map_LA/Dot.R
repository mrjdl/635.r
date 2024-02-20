#libraries
library(tidycensus)
library(tidyverse)
library(tmap)
library(mapview)
library(tigris)
library(viridis)

#install Census API:
# https://api.census.gov/data/key_signup.html
census_api_key("bfff7060ecfc2d4ad3de6c303c949e4f22c3255b", install=T, overwrite = T)

#use "view" for interactive plot; "plot" for static map
tmap_mode("view")


# Los Angeles
#retrieve race information from Census
md_race = get_decennial(
  geography = "county",
  state = "CA",
  county = "Los Angeles",
  variables = c(
    Latino = "P2_002N",
    White = "P2_005N",
    Black = "P2_006N",
    Asian = "P2_008N"
  ),
  year = 2020,
  geometry = TRUE
)


# convert to scattered dots for plotting
md_dots = as_dot_density(
  md_race,
  value = "value",
  values_per_dot = 2000,
  group = "variable"
)

background_tracts = filter(md_race, variable == "White")

# dot density plot
tm_shape(background_tracts) + 
  tm_polygons(col = "white", 
              border.col = "grey") + 
  tm_shape(md_dots) +
  tm_dots(col = "variable", 
          palette = "viridis",
          size = 0.025, 
          title = "1 dot = 2,000 people") + 
  tm_layout(legend.outside = TRUE,
            title = "Race/ethnicity,\n2020 US Census", scale = 1.5)


