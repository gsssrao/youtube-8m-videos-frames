# Check if FFMPEG is installed
YTDL=youtube-dl
command -v $YTDL >/dev/null 2>&1 || {
	echo >&2 "This script requires youtube-dl. Aborting."; exit 1;
}

# Check number of arguments
if [ "$#" -lt 2 ]; then
	echo "Usage: bash downloadvideos.sh <number-of-videos> <category-name>"
	exit 1
fi

txt=".txt"
name="${@:2}"

mid=$(grep -E "\t$name \(" youtube8mcategories.txt | grep -o "\".*\"" | sed -n 's/"\(.*\)"/\1/p')
mid=$mid$txt

mkdir -p videos

if [ "$1" -eq 0 ]; then
	while read line
		do
			# Use -f 22/best to download in whatever best format and quality available if not 22 i.e. mp4 720p
			$YTDL -f 22 "http://www.youtube.com/watch?v=$line" -o ./videos/"$name%(title)s-%(id)s.%(ext)s"
		done < category-ids/$mid
else
	limit=$1
	rm -rf log.txt
	while read line
		do
			if [ "$limit" -gt 0 ]; then
				limit=$(($limit-1))
				$YTDL -f 22 "http://www.youtube.com/watch?v=$line" -o ./videos/"$name%(title)s-%(id)s.%(ext)s" 2>&1 | tee log.txt
				error=$(grep -c ERROR log.txt)
				if [ "$error" -gt 0 ]; then
					limit=$(($limit+1))
				fi
				rm -rf log.txt
			else
				break
			fi
		done < category-ids/$mid
fi