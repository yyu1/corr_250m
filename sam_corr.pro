print, systime()

in_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/maxent_sam_hlorey_using_newprior_rfdi_corr.flt'
rfdi_file = '/Volumes/Global_250m/alos/sam/sam-alos/alos_2007_rfdi.flt'
elev_file = '/Volumes/Global_250m/layers/sam/srtm.bil'
stdv_file = '/Volumes/Global_250m/layers/sam/srtm_std_v2.bil'
hv_file = '/Volumes/Global_250m/alos/sam/sam-alos/alos_2007_hv.bil'


in_win_size = 10
xdim = 38400ULL
ydim = 43200ULL

correct_image, in_file, out_file, stdv_file, elev_file, rfdi_file, hv_file, in_win_size, xdim, ydim


print, systime()
end
