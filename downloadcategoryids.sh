# Check number of arguments
if [ "$#" -lt 2 ]; then
	echo "Usage: bash downloadcategoryids.sh <number-of-videos-per-category> <category-name>"
	exit 1
fi

js=".js"
txt=".txt"
name="${@:2}"
numVideos=$1
url='https://storage.googleapis.com/data.yt8m.org/2/j/v/'

echo "Number of videos: " $1

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X platform
    mid=$(grep -E "\t$name \(" youtube8mcategories.txt | grep -o "\".*\"" | sed -n 's/"\(.*\)"/\1/p')
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux platform
    mid=$(grep -P "\t$name \(" youtube8mcategories.txt | grep -o "\".*\"" | sed -n 's/"\(.*\)"/\1/p')
fi
txtName=$mid$txt
mid=$mid$js

mkdir -p category-ids

curl -o category-ids/$txtName $url$mid

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X platform
    grep -E -oh [a-zA-Z0-9_-]{4} category-ids/$txtName > category-ids/tmp$txtName
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux platform
    grep -P -oh [a-zA-Z0-9_-]{4} category-ids/$txtName > category-ids/tmp$txtName
fi

# First line is not tf-record-id
tail -n +2 category-ids/tmp$txtName > category-ids/$txtName

# Just keep as many tf-record-ids as necessary
if [ "$1" -eq 0 ]; then
    mv category-ids/$txtName category-ids/tmp$txtName
else
    awk -v var="$numVideos" ' NR <= var' category-ids/$txtName > category-ids/tmp$txtName
fi

# URL to get tf-id
url1='https://storage.googleapis.com/data.yt8m.org/2/j/i/'

# Get first two characters of tf-record
cut -c1-2 category-ids/tmp$txtName > category-ids/tmp2$txtName

rm -rf category-ids/$txtName

# Generate the url to fetch-youtube id in category-ids/$txtName
exec 6<"category-ids/tmp2$txtName"
while read -r line
do
    read -r firstTwoChars <&6
    echo "${url1}${firstTwoChars}/${line}.js" >> category-ids/$txtName
done <"category-ids/tmp${txtName}"
exec 6<&-

# Download actual youtube-video-id for each tf-record-id
rm -rf category-ids/tmp$txtName
while IFS= read -r line
do
    if [ "$(uname)" == "Darwin" ]; then
        # Mac OS X platform
        curl "$line" | grep -E -oh [a-zA-Z0-9_-]{11} >> category-ids/tmp$txtName
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # GNU/Linux platform
        curl "$line" | grep -P -oh [a-zA-Z0-9_-]{11} >> category-ids/tmp$txtName
    fi
done < category-ids/$txtName

# Cleanup
mv category-ids/tmp$txtName category-ids/$txtName
rm -rf category-ids/tmp$txtName
rm -rf category-ids/tmp2$txtName

echo "Completed downloading youtube video-ids"