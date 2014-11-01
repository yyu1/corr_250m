print, systime()

in_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_rfdi_corr.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter1.flt'
rfdi_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/alos_rfdi_test.flt'
hv_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/alos_hv_test.flt'
elev_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/srtm_elev_test.int'

in_win_size = 20
xdim = 12000ULL
ydim = 3700ULL


fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim

in_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter1.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter2.flt'
fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim
spawn, 'rm '+in_file

in_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter2.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter3.flt'
fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim
spawn, 'rm '+in_file

in_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter3.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter4.flt'
fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim
spawn, 'rm '+in_file

in_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter4.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter5.flt'
fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim
spawn, 'rm '+in_file

in_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter5.flt'
out_file = '/Volumes/Global_250m/output/sam/v3/rfdi_test/maxent_hlorey_sam_rfdi_test_fill_iter6.flt'
fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim
spawn, 'rm '+in_file

print, systime()
end
