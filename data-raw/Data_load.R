# Load all packages for load and preprocess dataset
library(readr)
library(dplyr)
library(tidyverse)
library(sf)
library(sp)
library(raster)
library(classInt)
library(ggplot2)

# Point cloud data
ptc <- read.table("data-raw/TsarmineRG_230914_frontonly_XYZ_dist_ref_220915.txt", header=FALSE, sep="")
colnames(ptc)<-c("Y","X","Z","d") # rename columns

# CSV data
data2020 <- read.csv("data-raw/census2020.csv")
subset2020 <- read.csv("data-raw/subset2020.csv")
LS_pa <- read.csv("data-raw/LS_pa.csv") 

# Shapefile data
Portugal <- st_read("data-raw/Shape/Area_Portugal.shp")
FFPorto <- st_read("data-raw/Shape/FF_Portugal.shp")
PortN <- st_read("data-raw/Shape/Porto_North.shp")
PortS <- st_read("data-raw/Shape/Porto_South.shp")
FF <- st_read("data-raw/Shape/ForestFires.shp")
FFN <- st_read("data-raw/Shape/FF_North.shp")
FFS <- st_read("data-raw/Shape/FF_South.shp")
river <- st_read("data-raw/Shape/Rio_Tajo.shp")

# Raster data
landCover <- as.factor(raster("data-raw/Raster/landCover.tif"))
geology <- as.factor(raster("data-raw/Raster/geology.tif"))
planCurv <- raster("data-raw/Raster/plan_curvature.tif")/100 # this because ArcGIS multiply 
profCurv <- raster("data-raw/Raster/profil_curvature.tif")/100 # ....curvature values by 100
TWI <- raster("data-raw/Raster/TWI.tif")
Slope <- raster("data-raw/Raster/Slope.tif")
dem <- raster("data-raw/Raster/DEM.tif")
dist <- raster("data-raw/Raster/dist_roads.tif")
# create a Raster stack
RF_features <- stack(dist, dem, TWI, planCurv, profCurv, Slope, geology, landCover)
# Renames the variables
names(RF_features)<-c("distRoad", "DEM", "TWI", "planCurv", "profCurv", "Slope", "Geology", "LandCover")
plot(RF_features)

# Save them
usethis::use_data(ptc, overwrite = TRUE)
usethis::use_data(data2020, overwrite = TRUE)
usethis::use_data(subset2020, overwrite = TRUE)
usethis::use_data(LS_pa, overwrite = TRUE)
usethis::use_data(Portugal, overwrite = TRUE)
usethis::use_data(FFPorto, overwrite = TRUE)
usethis::use_data(PortN, overwrite = TRUE)
usethis::use_data(PortS, overwrite = TRUE)
usethis::use_data(FF, overwrite = TRUE)
usethis::use_data(FFN, overwrite = TRUE)
usethis::use_data(FFS, overwrite = TRUE)
usethis::use_data(river, overwrite = TRUE)
usethis::use_data(landCover, overwrite = TRUE)
usethis::use_data(geology, overwrite = TRUE)
usethis::use_data(planCurv, overwrite = TRUE)
usethis::use_data(profCurv, overwrite = TRUE)
usethis::use_data(TWI, overwrite = TRUE)
usethis::use_data(Slope, overwrite = TRUE)
usethis::use_data(dem, overwrite = TRUE)
usethis::use_data(dist, overwrite = TRUE)
usethis::use_data(RF_features, overwrite = TRUE)