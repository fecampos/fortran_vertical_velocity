      subroutine cal_vertical(nx,ny,nz,Z,missing_val,f,g)

      implicit none

      integer, intent(in) :: nx, ny, nz

      real,intent(in) :: f(nx,ny,nz), Z(nz), missing_val

      real, intent(out) :: g(nx,ny,nz-1)

      real :: dz(nz-1), msk(nx,ny,nz), outmsk(nx,ny,nz-1)

      real :: f0(nx,ny,nz), f1(nx,ny,nz-1),f2(nx,ny,nz-1)

      integer :: i, j, k, l, msk2d(nx,ny)

      msk = 0
      where(f.ne.missing_val)
        msk = 1
      end where

      outmsk = 0.5*(msk(:,:,1:nz-1)+msk(:,:,2:nz))
      where (outmsk.eq.0.5)
        outmsk = 0
      end where

      msk2d = sum(outmsk,3)

      f0 = 0
      where(f.ne.missing_val)
        f0 = f
      end where

      f1 = 0.5*(f0(:,:,1:nz-1)+f0(:,:,2:nz))
      dz = Z(2:nz)-Z(1:nz-1)

      !OMP PARALLEL DO
      do j = 1,ny
        do i = 1,nx
          f1(i,j,:) = f1(i,j,:)*dz
        end do
      end do
      !OMP END PARALLEL DO  

      !OMP PARALLEL DO
      do j = 1,ny
        do i = 1,nx
          if (msk2d(i,j).ne.0) then
            l = msk2d(i,j)
            f2(i,j,1:l) = f1(i,j,l:1:-1)
          end if            
        end do
      end do
!            g(i,j,k) = sum(f1(i,j,l:nz-1))
      !OMP END PARALLEL DO  

      !OMP PARALLEL DO
      do k = 1,nz-1
        do j = 1,ny
          do i = 1,nx
            g(i,j,k) = sum(f2(i,j,1:k))
          end do
        end do
      end do
      !OMP END PARALLEL DO 
      
      where(outmsk.eq.0)
        g = missing_val    
      end where

      end subroutine
