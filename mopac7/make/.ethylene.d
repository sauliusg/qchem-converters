./outputs/ethylene.inp: ./ethylene.log
	@cd .; test -f ./outputs/ethylene.inp || sh -xc './ethylene.com > ethylene.log 2>&1'
	@cd .; test -f ./outputs/ethylene.inp && touch ./outputs/ethylene.inp
./outputs/ethylene.out: ./ethylene.log
	@cd .; test -f ./outputs/ethylene.out || sh -xc './ethylene.com > ethylene.log 2>&1'
	@cd .; test -f ./outputs/ethylene.out && touch ./outputs/ethylene.out
CLEAN_FILES += ./outputs/ethylene.inp ./outputs/ethylene.out
CLEAN_FILE_TARGETS += cleanfileethylene
cleanfileethylene:
	rm -f ./outputs/ethylene.inp
	rm -f ./outputs/ethylene.out
CLEAN_TARGETS +=cleanethylene
cleanethylene: cleanfileethylene
	rm -f ./ethylene.log
