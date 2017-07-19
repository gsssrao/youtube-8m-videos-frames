# Check if FFMPEG is installed
YTDL=youtube-dl
command -v $YTDL >/dev/null 2>&1 || {
	echo >&2 "This script requires youtube-dl. Aborting."; exit 1;
}

# Check number of arguments
if [ "$#" -lt 1 ]; then
	echo "Usage: bash downloadvideos.sh <category-name>"
	exit 1
fi

txt=".txt"
name="${@:1}"

mid=$(egrep "$name \(" youtube8mcategories.txt | grep -o "\".*\"" | sed -n 's/"\(.*\)"/\1/p')
mid=$mid$txt

mkdir -p videos

while read line
	do
		$YTDL -f 22 "http://www.youtube.com/watch?v=$line" -o ./videos/"$name%(title)s-%(id)s.%(ext)s"
	done < category-ids/$mid