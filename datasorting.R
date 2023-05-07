## get data sorted

library(sf)
library(tidyverse)
library(here)
library(raster)
library(tidycensus)
library(mapview)

datafolder <- file.path(here() %>% dirname(), 'assn5data')

national_lu_change <- raster(paste(datafolder, "nlcd_2001_2019_change_index_l48_20210604.img", sep = '/'))



delco <- get_decennial(geography = "county", state = 'PA', county= 'Delaware',
                                variables = "P013001", 
                                year = 2010,
                       geometry = T)

# ggplot(delco)+
#   geom_sf()


crs(national_lu_change) <- CRS('+init=EPSG:4269')

st_crs(delco) == st_crs(national_lu_change)

delco_lu_change <- national_lu_change %>% crop(delco)

plot(national_lu_change)

lu_2019<- raster(paste(datafolder, "nlcd_2019_land_cover_l48_20210604.img", sep = '/'))

lu_2019_big <- raster::aggregate(lu_2019, 100)
res(lu_2019_big)
mapview(lu_2019)
raster::plot(lu_2019)
ggplot(lu_2019)+
  geom_raster()
