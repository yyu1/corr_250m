print, systime()

in_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_rfdi_corr.flt'
rfdi_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/alos_rfdi_test.flt'
hv_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/alos_hv_test.flt'
elev_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/srtm_elev_test.int'
stdv_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/srtm_std_v2_test.int'


in_win_size = 10
xdim = 12000ULL
ydim = 3700ULL

correct_image, in_file, out_file, stdv_file, elev_file, rfdi_file, hv_file, in_win_size, xdim, ydim


print, systime()
end
