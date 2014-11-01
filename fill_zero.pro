;fills zero values in height where RFDI indicates it is forested

Function fill_zero, in_height, in_rfdi, in_hv
  ;threshold for stddev should be checked for outside of this function before invoking the function
  COMMON setting, rfdi_min, rfdi_max, win_size, min_fill_num, hv_min, hv_max, hv_min_high_elev ;winsize is # of pixels from center , win_size = 1 is 3x3

	index = where((in_rfdi gt rfdi_min) and (in_rfdi lt rfdi_max) and (in_height gt 0) and (in_hv lt hv_max), count)

	;Only fill if we have at least minimum pixels where rfdi is in range
	if (count ge min_fill_num) then begin
		rfdi_moment = moment(in_rfdi[index])
		hgt_moment = moment(in_height[index])
		return, hgt_moment[0] * (1. - (in_rfdi[win_size,win_size]-rfdi_moment[0])/rfdi_moment[0])
	endif
	return, 0.

End
