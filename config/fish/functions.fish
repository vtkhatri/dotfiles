function cdu
	cd (string split -r -m1 $argv/ $PWD)[1]$argv
end
