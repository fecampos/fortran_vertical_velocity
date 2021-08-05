# fortran Vertical Velocity

This library contains Fortran scripts to compute eulerian vertical velocity using equation (1) from Lian et al., (2017)


**References**

Liang, X., Spall, M., & Wunsch, C. (2017). Global ocean vertical velocity from a dynamically consistent ocean state estimate. Journal of Geophysical Research: Oceans, 122, 8208–8224.

 **Getting Started**

1. Open *param.f90* and modify line 5,7-12 with your netcdf file (file_in), time (t_NAME), lon (x_NAME), lat (y_NAME), depth (z_NAME) and u and v velocity (u_NAME and v_NAME):
```
      character(len=*),parameter :: file_in = "in.nc"     
      character(len=*),parameter :: t_NAME = "time"
      character(len=*),parameter :: x_NAME = "longitude"
      character(len=*),parameter :: y_NAME = "latitude"
      character(len=*),parameter :: z_NAME = "depth"
      character(len=*),parameter :: u_NAME = "uo"
      character(len=*),parameter :: v_NAME = "vo"
```

Also modify line 15 and 21 with your lon grid number (nx), lat grid number (ny), depth grid number (nz), time steps (nt), missing_val , scale factor (sf_sla) and add offset (af_sla):
```
      integer, parameter :: nx = 1321, ny = 481, nz = 50, nt = 1

      real, parameter :: missing_val = -32767, sf_sla = 0.000610370188951492, af_sla = 0
```

3. Open *jobcomp* and modify NETCDFLIB and NETCDFINC path with your netcdf path
