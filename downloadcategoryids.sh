# Check if FFMPEG is installed
GSUTIL=gsutil
command -v $GSUTIL >/dev/null 2>&1 || {
	echo >&2 "This script requires gsutil. Aborting."; exit 1;
}
# Check number of arguments
if [ "$#" -lt 1 ]; then
	echo "Usage: bash downloadcategoryids.sh <category-name>"
	exit 1
fi

js=".js"
name="${@:1}"
url='gs://data.yt8m.org/1/j/'
# echo $name

mid=$(grep -P "\t$name \(" youtube8mcategories.txt | grep -o "\".*\"" | sed -n 's/"\(.*\)"/\1/p')
mid=$mid$js
# echo $mid

mkdir -p category-ids

$GSUTIL cp $url$mid category-ids/
grep -P -oh [a-zA-Z0-9_-]{11} category-ids/$mid > category-ids/"${mid%.*}".txt
rm -rf category-ids/$mid