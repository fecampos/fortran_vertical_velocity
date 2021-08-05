      module param

      implicit none

      character(len=*),parameter :: file_in = "in.nc"
     
      character(len=*),parameter :: t_NAME = "time"
      character(len=*),parameter :: x_NAME = "longitude"
      character(len=*),parameter :: y_NAME = "latitude"
      character(len=*),parameter :: z_NAME = "depth"
      character(len=*),parameter :: u_NAME = "uo"
      character(len=*),parameter :: v_NAME = "vo"
      character(len=*),parameter :: w_NAME = "wo"

      integer, parameter :: nx = 1321, ny = 481, nz = 50, nt = 1

      integer :: i, j, k

      real, parameter :: pi = 3.1415927

      real, parameter :: missing_val = -32767, sf_sla = 0.000610370188951492, af_sla = 0

      real :: T(nt), X(nx), Y(ny), Z(nz), wo(nx,ny,nz-1,nt), uo(nx,ny,nz,nt), vo(nx,ny,nz,nt)

      integer :: ncid, retval, tvarid, xvarid, yvarid, zvarid, uovarid, vovarid, wovarid

      end module
