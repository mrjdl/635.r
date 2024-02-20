library(sf) # For reading shapefiles
library(tmap) # for plotting

#the Prison Policy Initiative produced a point shapefile with 
#the correctional population counts for each block in the country

shapefile_path <- "Correctional_Populations_2020_Census.shp"
sf_object <- st_read(shapefile_path)


tmap_mode("view")
tm_shape(sf_object) +
  tm_dots(size = 0.1, col = "blue") +  # Adjust size and color as needed
  tm_basemap(server = "OpenStreetMap")





