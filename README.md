# CLI tool to get a random image from unsplash and set it as a backgroud image (wallpaper) on macos

## Requirements
- `Ruby`
- Gems
  - `ferrum`
  - `open-uri`
  - `thor`

## Usage

```
Commands:
  wallpaper.sh help [COMMAND]     # Describe available commands or one specific command
  wallpaper.sh q SEARCH1,SEARCH2  # Get random image from search
  wallpaper.sh random             # Get random image
  wallpaper.sh user NAME          # Get random image from user NAME

Options:
  s, [--size=SIZE]                  # Specify image size
  h, [--headless], [--no-headless]  # Hide browser window
                                    # Default: true
```

## Used URLs

```
https://source.unsplash.com/random
https://source.unsplash.com/user/erondu
https://source.unsplash.com/user/erondu/1920x1080
https://source.unsplash.com/user/erondu/likes
https://source.unsplash.com/1600x900/?nature,water
```