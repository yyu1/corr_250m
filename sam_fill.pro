print, systime()

in_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior_rfdi_corr.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior_rfdi_corr_fill_iter1.flt'
rfdi_file = '/Volumes/Global_250m/alos/sam/sam-alos/alos_2007_rfdi.flt'
hv_file = '/Volumes/Global_250m/alos/sam/sam-alos/alos_2007_hv.bil'
elev_file = '/Volumes/Global_250m/layers/sam/srtm.bil'

in_win_size = 20
xdim = 38400ULL
ydim = 43200ULL


fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim

in_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior_rfdi_corr_fill_iter1.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior_rfdi_corr_fill_iter2.flt'
fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim
spawn, 'rm '+in_file

in_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior_rfdi_corr_fill_iter2.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior_rfdi_corr_fill_iter3.flt'
fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim
spawn, 'rm '+in_file

in_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior_rfdi_corr_fill_iter3.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior_rfdi_corr_fill_iter4.flt'
fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim
spawn, 'rm '+in_file

print, systime()
end
