      program main_code

      use netcdf 

      use param

      implicit none

      real, dimension(nx,ny,nz) :: dudx, dudy, dvdx, dvdy, div

      retval = nf90_open(file_in, NF90_NOWRITE, ncid)
      retval = nf90_inq_varid(ncid, x_NAME, xvarid)
      retval = nf90_get_var(ncid, xvarid, X)      
      retval = nf90_inq_varid(ncid, y_NAME, yvarid)
      retval = nf90_get_var(ncid, yvarid, Y)
      retval = nf90_inq_varid(ncid, z_NAME, zvarid)
      retval = nf90_get_var(ncid, zvarid, Z)
      retval = nf90_inq_varid(ncid, t_NAME, tvarid)
      retval = nf90_get_var(ncid, tvarid, T)
      retval = nf90_inq_varid(ncid, u_NAME, uovarid)
      retval = nf90_get_var(ncid, uovarid, uo)
      retval = nf90_inq_varid(ncid, v_NAME, vovarid)
      retval = nf90_get_var(ncid, vovarid, vo)
      retval = nf90_close(ncid)     
    
      where(uo.ne.missing_val)
        uo = uo*sf_sla+af_sla
      end where

      where(vo.ne.missing_val)
        vo = vo*sf_sla+af_sla
      end where

      !OMP PARALLEL DO      
      do i = 1,nz
        call gradient(nx,ny,missing_val,X,Y,uo(:,:,i,:),dudx(:,:,i),dudy(:,:,i))
      end do
      !OMP END PARALLEL DO

      !OMP PARALLEL DO      
      do i = 1,nz
        call gradient(nx,ny,missing_val,X,Y,vo(:,:,i,:),dvdx(:,:,i),dvdy(:,:,i))
      end do
      !OMP END PARALLEL DO

      div = missing_val
      where ((dudx.ne.missing_val).and.(dvdy.ne.missing_val))
        div = dudx+dvdy
      end where

      call cal_vertical(nx,ny,nz,Z,missing_val,div,wo)

      call write_vertical_velocity(nx,ny,nz-1,nt,X,Y,0.5*(Z(1:nz-1)+Z(2:nz)), &
           &T,missing_val,wo)

      end program
