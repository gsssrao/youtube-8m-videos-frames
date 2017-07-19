# Youtube-8m Videos and Frames Generator
This repository contains scripts for downloading videos corresponding to a particular or a few categories of [youtube-8m dataset](https://research.google.com/youtube8m/index.html).

The official `youtube-8m dataset` website contains information for downloading only videos and frame level features in the format of tensorflow protocal buffers. Hence, in this repository I wrote a few bash scripts for download ids, videos and frames of youtube-8m dataset.

## Dependencies

### Dependencies for downloading youtube video ids for categories
* [gsutil](https://cloud.google.com/storage/docs/gsutil_install)

### Dependencies for downloading youtube videos from ids
* [youtube-dl](https://github.com/rg3/youtube-dl#installation)

### Dependencies for generation frames from videos
* [ffmpeg](https://www.ffmpeg.org/download.html)

## TODO
- [ ] Improve the video generation using a file for categories

## Usage 
First look up the category you want to download from `youtube8mcategories.txt`. The number of videos on youtube corresponding to that category is listed under the parenthesis.

Say, you are interested in the category `The Walt Disney Company` copy its name (You can see that there are 20674 videos corresponding to this category as listed under the parenthesis corresponding to it).

### Download video-ids  
The first step is to download video-ids corresponding to the category. Say, you want to
```
bash downloadcategoryids.sh <category-name>
```

This downloads youtube-ids corresponding to the `category-name` under the folder `category-ids`

#### Example usage
```
bash downloadcategoryids.sh The Walt Disney Company
```

Be really careful and don't include any extra spaces after the category name. 
Correct category name: `The Walt Disney Company`
Incorrect category name: `The Walt Disney Company ` or ` The Walt Disney Company` etc.

### Download videos  
The next step is to download videos corresponding to the video-ids downloaded in the previous step.
```
bash downloadvideos.sh <category-name>
```

This downloads youtube videos corresponding to the `category-name` under the folder `videos`. 

By default it tries to download the video only if a `mp4` is present of `1280x720` resolution. You can change this by changing the value for `-f` modifier in `downloadvideos.sh` (`-f 22` stands for `mp4 1280x720`). To list the types of formats supported refer this stackoverflow [question](https://askubuntu.com/questions/486297/how-to-select-video-quality-from-youtube-dl).

#### Example usage
```
bash downloadvideos.sh The Walt Disney Company
```

Again be careful and don't include any extra spaces after the category name. 
Correct category name: `The Walt Disney Company`
Incorrect category name: `The Walt Disney Company ` or ` The Walt Disney Company` etc.

### Generate Frames

The next step is to generate frames corresponding to the videos downloaded in the previous step.
```
bash generateframesfromvideos.sh <path_to_directory_containing_videos> <path_to_directory_to_store_frames> <frames_format>
```

This generates the frames corresponding to the videos. In `<frame_format>` you can specify `png`(lossless compression) or `jpg`(lossy compression) or `bmp`(lossless) etc.

For file size of the frames is in the following order: `bmp` > `png` > `jpg`

I would suggest to use `png` if `bmp` is not specifically required. 

#### Example usage
```
mkdir frames
bash generateframesfromvideos.sh videos frames png
```
This will generates frames in `frames` folder.


## Contact

If you have any questions or suggestions about the code, feel free to create an issue.

