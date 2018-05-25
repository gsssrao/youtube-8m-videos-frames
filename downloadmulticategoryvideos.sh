# Check number of arguments
if [ "$#" != "2" ]; then
	echo "Usage: bash downloadmulticategoryvideos.sh <number-of-videos-per-category> <selected-category-file-name>"
	exit 1
fi

while read line
	do
		bash downloadcategoryids.sh $1 "${line}"
		bash downloadvideos.sh $1 "${line}"
	done < "$2"