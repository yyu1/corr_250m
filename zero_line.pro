;Zeros values for the given height line based on different parameters
Pro zero_line, ht_line, elev_line, stdv_line, hv_line, rfdi_line
	COMMON setting, rfdi_min, rfdi_max, win_size, elev_thresh, hv_min_low_elev, hv_min_high_elev


	index = where((elev_line le elev_thresh) and (hv_line lt hv_min_low_elev), count)
	if (count gt 0) then ht_line[index] = 0

	index = where((elev_line gt elev_thresh) and (rfdi_line gt rfdi_max) and (hv_line lt hv_min_high_elev), count)
	if (count gt 0) then ht_line[index] = 0

	index = where((rfdi_line gt 0.65) and (hv_line lt 0.01), count)
	if (count gt 0) then ht_line[index] = 0

End
