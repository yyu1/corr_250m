Pro fill_image, in_file, out_file, rfdi_file, hv_file, elev_file, in_win_size, xdim, ydim
	COMMON setting, rfdi_min, rfdi_max, win_size, min_fill_num, hv_min, hv_max, hv_min_high_elev

	win_size = in_win_size
	rfdi_min = 0.2
	rfdi_max = 0.8
	min_fill_num = 10
	hv_min = 0.02
	hv_max = 0.13
	hv_min_high_elev = 0.015
	elev_thresh = 800

	;----------------------------------

	in_ht_image = fltarr(xdim, win_size*2+1)
	in_hv_image = fltarr(xdim, win_size*2+1)
	in_rfdi_image = fltarr(xdim, win_size*2+1)

	ht_box = fltarr(win_size*2+1,win_size*2+1)
	hv_box = fltarr(win_size*2+1,win_size*2+1)
	rfdi_box = fltarr(win_size*2+1,win_size*2+1)
	

	out_line = fltarr(xdim)
	cur_line = fltarr(xdim)
	hv_line = fltarr(xdim)
	elev_line = intarr(xdim)

	cur_hv_line = fltarr(xdim)
	cur_rfdi_line = fltarr(xdim)

	openr, in_ht_lun, in_file, /get_lun
	openr, in_rfdi_lun, rfdi_file, /get_lun
	openr, in_hv_lun, hv_file, /get_lun
	openr, in_elev_lun, elev_file, /get_lun
	openw, out_ht_lun, out_file, /get_lun


	;copy first win_size # of lines, these do not get worked on

	for j=0ULL, win_size-1 do begin
		readu, in_ht_lun, out_line
		writeu, out_ht_lun, out_line
	endfor

	;perform fill
	for j=ulong(win_size), ydim-win_size-1 do begin
		;move file pointers
		point_lun, in_ht_lun, (j-win_size)*xdim*4ULL
		point_lun, in_rfdi_lun, (j-win_size)*xdim*4ULL
		point_lun, in_hv_lun, (j-win_size)*xdim*4ULL
		point_lun, in_elev_lun, (j-win_size)*xdim*2ULL

		;read input data
		readu, in_ht_lun, in_ht_image
		readu, in_hv_lun, in_hv_image
		readu, in_rfdi_lun, in_rfdi_image
		readu, in_elev_lun, elev_line

		out_line[*] = in_ht_image[*,win_size]

		cur_hv_line[*] = in_hv_image[*,win_size]
		cur_rfdi_line[*] = in_rfdi_image[*,win_size]

		cur_line[*] = out_line[*]
	
		flag_low = (elev_line le elev_thresh) and (cur_hv_line gt hv_min)
		flag_high = (elev_line gt elev_thresh) and (cur_hv_line gt hv_min_high_elev) 
		flag_rfdi = (cur_rfdi_line ge rfdi_min) and (cur_rfdi_line le rfdi_max) and (out_line eq 0)

		index = where((flag_low and flag_rfdi) or (flag_high and flag_rfdi), count)
		
		if (count gt 0) then begin
			for i=0ULL, count-1 do begin
				if ((index[i] ge win_size) and (index[i] le (xdim-win_size-1))) then begin
					ht_box[*] = in_ht_image[index[i]-win_size:index[i]+win_size,*]
					hv_box[*] = in_hv_image[index[i]-win_size:index[i]+win_size,*]
					rfdi_box[*] = in_rfdi_image[index[i]-win_size:index[i]+win_size,*]

					out_line[index[i]]=fill_zero(ht_box,rfdi_box, hv_box)
				endif
			endfor
		endif

		writeu, out_ht_lun, out_line

	endfor


	;fill last win_size # of lines.

	point_lun, in_ht_lun, (ydim-win_size) * xdim * 4ULL
	for j=0ULL, win_size-1 do begin
		readu, in_ht_lun, out_line
		writeu, out_ht_lun, out_line
	endfor

	free_lun, in_ht_lun
	free_lun, in_rfdi_lun
	free_lun, in_hv_lun
	free_lun, in_elev_lun
	free_lun, out_ht_lun

End
