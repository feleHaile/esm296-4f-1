library(sp)
library(rgdal)
library(dismo)

# set variables to the scientific name of your speciess
genus   = 'Pinus'
species = 'longaeva'

# path to output shapefile constructed from scientific name of your speciess
#shp = sprintf('H:/esm296-4f/project/data/pts_%s_%s', genus, species)
# OR
shp = 'H:/esm296-4f/lab5/raw/pts_pinulong'

# get data from Global Biodiversity Information Facility (GBIF)
sp = gbif(genus, species, sp=T, removeZeros=T)

# set geographic coordinate system
proj4string(sp) = CRS('+proj=longlat +datum=WGS84')

# make folder if doesn't exist
dir.create(dirname(shp), showWarnings=F, recursive=T)

# write to shapefile
writeOGR(sp, dsn=dirname(shp), layer=basename(shp), driver='ESRI Shapefile')
# You'll get the following message, which is OK. Just a limitation of the shapefile format: only 10 characters.
#
# Warning message:
# In writeOGR(sp, dsn = dirname(shp), layer = basename(shp), driver = "ESRI Shapefile") :
#   Field names abbreviated for ESRI Shapefile driver


