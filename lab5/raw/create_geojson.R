library(sp)
library(rgdal)

# set paths ----

USER        = 'skymurph' # change this to YOUR Github username
paths = list(
  pts = list(
    shp     = 'H:/esm296-4f/lab5/raw/pts_pinulong',
    geojson = sprintf('H:/esm296-4f/%s.github.io/map/pts_pinulong.geojson', USER)),
  ply = list(
    shp     = 'H:/esm296-4f/lab5/raw/pinulong',
    geojson = sprintf('H:/esm296-4f/%s.github.io/map/ply_pinulong.geojson', USER)))

# create GeoJSON ----

for (fc in c('pts','ply')){
  
  # show variables
  shp = paths[[fc]][['shp']]
  geo = paths[[fc]][['geojson']]
  cat(sprintf('%s: %s -> %s\n', fc, shp, geo))
  
  # create output path if needed, delete existing
  dir.create(dirname(geo), recursive=T, showWarnings=F)
  unlink(geo)
  
  # read in as sp object
  sp = readOGR(dirname(shp), basename(shp))
  
  # set projection
  if (is.na(proj4string(sp))){
    cat('  assigning WGS84 projection\n')
    proj4string(sp) = CRS('+proj=longlat +ellps=WGS84 +datum=WGS84')
  }
  
  # spit out center and extent
  xy = rowMeans(bbox(sp))
  cat(sprintf('  center (lat, lon): %g, %g\n', xy[1], xy[2]))
  
  # output to geojson
  tmp = tempfile()
  writeOGR(sp, tmp, 'OGRGeoJSON', driver='GeoJSON')
  file.rename(tmp, geo)
}
