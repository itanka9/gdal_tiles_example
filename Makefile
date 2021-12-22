EAST:='https://eoimages.gsfc.nasa.gov/images/imagerecords/57000/57752/land_shallow_topo_east.tif'
WEST:='https://eoimages.gsfc.nasa.gov/images/imagerecords/57000/57752/land_shallow_topo_west.tif'

earthtiles: east.tif west.tif
	mkdir -p tiles
	gdal2tiles.py --xyz east.tif tiles/
	gdal2tiles.py --xyz west.tif tiles/

east.tif: east_raw.tif
	gdal_translate -of GTiff -a_srs WGS84 -a_ullr 0 90 180 -90 east_raw.tif $@

west.tif: west_raw.tif
	gdal_translate -of GTiff -a_srs WGS84 -a_ullr -180 90 0 -90 west_raw.tif $@

east_raw.tif:
	wget ${EAST} -O $@

west_raw.tif:
	wget ${WEST} -O $@

clean:
	rm -fr *.tif tiles