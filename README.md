# Youtube-8m Videos and Frames Generator
This repository contains scripts for downloading videos corresponding to a particular or a few categories of [youtube-8m dataset](https://research.google.com/youtube8m/index.html).

The official `youtube-8m dataset` website contains information for downloading only videos and frame level features in the format of tensorflow protocal buffers. Hence, in this repository I wrote a few bash scripts for download ids, videos and frames of youtube-8m dataset.

**UPDATED to support May 2018 version which has 6.1M videos, 3862 classes** (The older Feb 2017 version of the Youtube8M dataset had 7.0M videos and 4716 classes). You can access the older version of this repository which worked with the Feb 2017 version from [this link](https://github.com/gsssrao/youtube-8m-videos-frames/tree/4b4c35e8698a3b4222a680f5ad1e8df37b7cbe66)

A summary of how this repository works can be found [here](https://github.com/gsssrao/youtube-8m-videos-frames/issues/2).

## Dependencies

Dependencies for downloading youtube video ids for categories

* Basic bash commands like grep, awk and cut should work.

Dependencies for downloading youtube videos from ids

* [youtube-dl](https://github.com/rg3/youtube-dl#installation)

Dependencies for generation of frames from videos

* [ffmpeg](https://www.ffmpeg.org/download.html)

## TODO
- [x] Improve the video generation using a file for categories
- [x] Add support for video limit per category

## Usage 

First look up the categories you want to download from `youtube8mcategories.txt`. The number of videos on youtube corresponding to that category is listed under the parenthesis.

Copy all these categories to a txt file with each category in a new line. Make sure that you don't add any extra characters to category name and that you add a new line after the last category.

Check `selectedcategories.txt` for example format. 


### Download multiple category videos and ids

```
bash downloadmulticategoryvideos.sh <number-of-videos-per-category> <selected-category-file-name>
```

This downloads youtube-ids corresponding to the categories in `<selected-category-file-name>` file under the folder `category-ids`. It also downloads `<number-of-videos-per-category>` videos per category in `videos` folder (The video names have a prefix as their category name). If you would like to download all the videos specify `<number-of-videos-per-category>` as `0`.

By default a video is downloaded in the best possible resolution. If you want to download only an `mp4` of a fixed resolution like `1280x720`, you can do this changing the value for `-f` modifier in `downloadvideos.sh` at line numbers `31` and `40` (`-f 22` stands for `mp4 1280x720` whereas `-f best` stands for best possible resolution). To list the types of formats supported refer this stackoverflow [question](https://askubuntu.com/questions/486297/how-to-select-video-quality-from-youtube-dl).


***Example Usage***
```
 bash downloadmulticategoryvideos.sh 10 selectedcategories.txt
```

This will download 10 videos for each category in `selectedcategories.txt`

### Generate Frames

The next step is to generate frames corresponding to the videos downloaded in the previous step.
```
bash generateframesfromvideos.sh <path_to_directory_containing_videos> <path_to_directory_to_store_frames> <frames_format>
```

This generates the frames corresponding to the videos. In `<frame_format>` you can specify `png`(lossless compression) or `jpg`(lossy compression) or `bmp`(lossless) etc.

The file size of the frames is the following order: `bmp` > `png` > `jpg`

I would suggest to use `png` if `bmp` is not specifically required. 

***Example usage***
```
mkdir frames
bash generateframesfromvideos.sh videos frames png
```
This will generates frames in `png` format under the `frames` folder.

### Optional Usage

#### Download video-ids  

```
bash downloadcategoryids.sh <number-of-videos> <category-name>
```

This downloads `<number-of-videos>` youtube-ids corresponding to the `category-name` under the folder `category-ids`. If you would like to download all the videos specify `<number-of-videos>` as `0`.

***Example usage***

```
bash downloadcategoryids.sh 0 The Walt Disney Company
```

Be really careful and don't include any extra spaces after the category name. 

Correct category name: "The Walt Disney Company"

Incorrect category name: "The Walt Disney Company " or " The Walt Disney Company" etc.

#### Download videos 

To download videos corresponding to the video-ids downloaded in the previous step.
```
bash downloadvideos.sh <number-of-videos> <category-name>
```

This downloads `<number-of-videos>` youtube videos corresponding to the `category-name` under the folder `videos`. If you want to download all the videos of the category specify `<number-of-videos>` as `0`

By default a video is downloaded in the best possible resolution. If you want to download only an `mp4` of a fixed resolution like `1280x720`, you can do this changing the value for `-f` modifier in `downloadvideos.sh` at line numbers `31` and `40` (`-f 22` stands for `mp4 1280x720` whereas `-f best` stands for best possible resolution). To list the types of formats supported refer this stackoverflow [question](https://askubuntu.com/questions/486297/how-to-select-video-quality-from-youtube-dl).

***Example usage***
```
bash downloadvideos.sh 10 The Walt Disney Company
```

This will download 10 videos of the `The Walt Disney Company` category in the `videos` folder.


## Contact

If you have any questions or suggestions about the code, feel free to create an issue.

