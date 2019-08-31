# Youtube API v3 (youtube_api3)

Flutter package for Youtube API v3.

## API's supported with parameters

* PlaylistItems
  * playlistId
  * part
    * snippet
  * maxResult

## Getting Started

To use this package, add the dependency to your pubspec.yaml file

```yaml
dependencies:
  ...
  youtube_api_v3: ^0.0.1
```

## Usage

```dart
import 'package:youtube_api_v3/youtube_api_v3.dart';
YoutubeAPIv3 api = new YoutubeAPIv3({key});
/// List of videos from playlist
PlayListItemListResponse playlist = await api.playListItems2(
    {playlistId},
    {maxResults},
    {part});

List<PlayListItem> videos = playlist.items;
```
