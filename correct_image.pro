;Prodecure for applying RFDI correction on a 250m image

PRO correct_image, in_file, out_file, stdv_file, elev_file, rfdi_file, hv_file, in_win_size, xdim, ydim
	COMMON setting, rfdi_min, rfdi_max, win_size, elev_thresh, hv_min_low_elev, hv_min_high_elev

	win_size = in_win_size

	rfdi_min = 0.2
	rfdi_max = 0.8

	stdv_min = 50
	srtm_min = 1000

	elev_thresh = 500
	hv_min_low_elev = 0.02
	hv_min_high_elev = 0.015

	;---------------------

 	in_ht_image = fltarr(xdim, win_size*2+1)
 	in_rfdi_image = fltarr(xdim, win_size*2+1)
  in_elev_image = intarr(xdim, win_size*2+1)
  in_stdv_image = intarr(xdim, win_size*2+1)

  ht_box = fltarr(win_size*2+1,win_size*2+1)
  rfdi_box = fltarr(win_size*2+1,win_size*2+1)
 ; elev_box = intarr(win_size*2+1,win_size*2+1)
 ; stdv_box = intarr(win_size*2+1,win_size*2+1)


  out_line = fltarr(xdim)
  cur_line = fltarr(xdim)
	rfdi_line = fltarr(xdim)
	hv_line = fltarr(xdim)

  cur_elev_line = intarr(xdim)
  cur_stdv_line = intarr(xdim)

  openr, in_ht_lun, in_file, /get_lun
  openr, in_hv_lun, hv_file, /get_lun
  openr, in_rfdi_lun, rfdi_file, /get_lun
  openr, in_elev_lun, elev_file, /get_lun
  openr, in_stdv_lun, stdv_file, /get_lun
  openw, out_lun, out_file, /get_lun

  ;copy first win_size # of lines, these do not get worked on

  for j=0ULL, win_size-1 do begin
    readu, in_ht_lun, out_line
		readu, in_rfdi_lun, rfdi_line
		readu, in_elev_lun, cur_elev_line
		readu, in_hv_lun, hv_line
		readu, in_stdv_lun, cur_stdv_line
		zero_line, out_line, cur_elev_line, cur_stdv_line, hv_line, rfdi_line
    writeu, out_lun, out_line
  endfor

	;perform correction

	for j=ulong(win_size), ydim-win_size-1 do begin
		;move file pointers
		point_lun, in_ht_lun, (j-win_size)*xdim*4ULL
    point_lun, in_rfdi_lun, (j-win_size)*xdim*4ULL
    point_lun, in_elev_lun, (j-win_size)*xdim*2ULL
    point_lun, in_stdv_lun, (j-win_size)*xdim*2ULL

    ;read input data
    readu, in_ht_lun, in_ht_image
    readu, in_rfdi_lun, in_rfdi_image
    readu, in_elev_lun, in_elev_image
    readu, in_stdv_lun, in_stdv_image
		readu, in_hv_lun, hv_line

		cur_line[*] = in_ht_image[*,win_size]
		out_line[*] = cur_line[*]
		rfdi_line[*] = in_rfdi_image[*,win_size]
	
		cur_elev_line[*] = in_elev_image[*,win_size]
		cur_stdv_line[*] = in_stdv_image[*,win_size]

		zero_line, out_line, cur_elev_line, cur_stdv_line, hv_line, rfdi_line

		index = where((cur_line gt 0) and (cur_elev_line gt srtm_min) and (cur_stdv_line gt stdv_min), count)

		if (count gt 0) then begin
			for i=0ULL, count-1 do begin
				if ((index[i] ge win_size) and (index[i] le (xdim-win_size-1))) then begin

					ht_box[*] = in_ht_image[index[i]-win_size:index[i]+win_size,*]
					rfdi_box[*] = in_rfdi_image[index[i]-win_size:index[i]+win_size,*]
					;elev_box[*] = in_elev_image[index[i]-win_size:index[i]+win_size,*]
					;stdv_box[*] = in_stdv_image[index[i]-win_size:index[i]+win_size,*]

					out_line[index[i]]=apply_corr(ht_box, rfdi_box)
				endif
			endfor
		endif

		writeu, out_lun, out_line
	endfor


  ;fill last win_size # of lines.

  point_lun, in_ht_lun, (ydim-win_size) * xdim * 4ULL
  point_lun, in_rfdi_lun, (ydim-win_size) * xdim * 4ULL
	point_lun, in_elev_lun, (ydim-win_size) * xdim * 2ULL
	point_lun, in_stdv_lun, (ydim-win_size) * xdim * 2ULL
  for j=0ULL, win_size-1 do begin
    readu, in_ht_lun, out_line
		readu, in_rfdi_lun, rfdi_line
		readu, in_elev_lun, cur_elev_line
		readu, in_hv_lun, hv_line
		readu, in_stdv_lun, cur_stdv_line
		zero_line, out_line, cur_elev_line, cur_stdv_line, hv_line, rfdi_line
    writeu, out_lun, out_line
  endfor

End
