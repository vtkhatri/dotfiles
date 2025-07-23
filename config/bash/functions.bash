function cdu {
	cd ${PWD%$1/*}$1
}
