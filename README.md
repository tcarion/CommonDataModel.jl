[![Build Status](https://github.com/JuliaGeo/CommonDataModel.jl/workflows/CI/badge.svg)](https://github.com/JuliaGeo/CommonDataModel.jl/actions)
[![codecov.io](http://codecov.io/github/JuliaGeo/CommonDataModel.jl/coverage.svg?branch=main)](http://app.codecov.io/github/JuliaGeo/CommonDataModel.jl?branch=main)
[![documentation dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliageo.github.io/CommonDataModel.jl/dev/)


This package contains abstracts type definition to ensure compatibility of the package [GRIBDatasets](https://github.com/JuliaGeo/GRIBDatasets.jl) and [NCDatasets](https://github.com/Alexander-Barth/NCDatasets.jl) for manipulating GRIB and NetCDF files. This package aims to follow the [Common Data Model](https://docs.unidata.ucar.edu/netcdf-c/current/netcdf_data_model.html) and the [CF (climate and forecast models) Metadata Conventions](https://cfconventions.org/).

This package is at a very early state of developpement.

Here is minimal example for loading GRIB or NetCDF files.

``` julia
import CommonDataModel as CDM
import SomeDatasets # where SomeDatasets is either GRIBDatasets or NCDatasets

ds = SomeDatasets.Dataset("file_name")

# ntime is the number of time instances
ntime = CDM.dims(ds)["time"]

# create an array-like structure v corresponding to variable temperature
v = ds["temperature"]

# load a subset
subdata = v[10:30,30:5:end]

# load all data
data = v[:,:]

# load a global attribute
title = CDM.attribs(ds)["title"]
close(ds)
```

 Most users would typically import [`GRIBDatasets`](https://github.com/JuliaGeo/GRIBDatasets.jl) and [`NCDatasets`](https://github.com/Alexander-Barth/NCDatasets.jl) directly and not `CommonDataModel`. One should import `CommonDataModel` only to extent the functionality of `GRIBDatasets` and `NCDatasets`.

As a proof-of-concept, there is also an [`TIFFDatasets`](https://github.com/Alexander-Barth/TIFFDatasets.jl) package for GeoTIFF files.

# File conversions

By implementing a common interface, GRIB files can be converted to NetCDF files using
`NCDatasets.write`:

```julia
using NCDatasets
using GRIBDatasets
using Downloads: download

grib_file = download("https://github.com/JuliaGeo/GRIBDatasets.jl/raw/98356af026ea39a5ec0b5e64e4289105492321f8/test/sample-data/era5-levels-members.grib")
netcdf_file = "test.nc"
NCDatasets.write(netcdf_file,GRIBDataset(grib_file))
```
