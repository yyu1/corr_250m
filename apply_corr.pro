;This function applies the RFDI correction and returns an array/vector of the same size


Function apply_corr, in_height, in_rfdi

	;threshod for stddev should be checked for outside of this function before invoking the function
	COMMON setting, rfdi_min, rfdi_max, win_size, elev_thresh, hv_min_low_elev, hv_min_high_elev ;winsize is # of pixels from center , win_size = 1 is 3x3

	index = where((in_rfdi gt rfdi_min) and (in_rfdi lt rfdi_max) and (in_height gt 0), count)

	;Only perform correction if we have at least one third of the window satisfying the rfdi condition

	if ((count gt ((2*win_size+1)^2)/3) and ((in_rfdi[win_size,win_size] gt rfdi_min) and (in_rfdi[win_size,win_size] lt rfdi_max))) then begin
		;fill with either ALOS HV or RFDI
		;statistical tests
		rfdi_moment = moment(in_rfdi[index])
		hgt_moment = moment(in_height[index])
		rfdi_covar = rfdi_moment[1]/rfdi_moment[0]
		hgt_covar = hgt_moment[1]/hgt_moment[0]
		
		;correct if coefficient of var in height is bigger than rfdi
		if (hgt_covar gt rfdi_covar) then  begin
			return, hgt_moment[0] * (1. - (in_rfdi[win_size,win_size] - rfdi_moment[0])/rfdi_moment[0])
		endif else begin
			return, in_height[win_size,win_size]
		endelse

	endif else begin
		return, in_height[win_size,win_size]
	endelse

End
