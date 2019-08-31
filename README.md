# Youtube API v3 (youtube_api3)

Flutter package for Youtube API v3.

## API's supported with parameters

* PlaylistItems
  * playlistId
  * part
    * snippet
    * id
    * contentDetails
    * status
  * maxResult
  * pageToken

## Getting Started

To use this package, add the dependency to your pubspec.yaml file

```yaml
dependencies:
  ...
  youtube_api_v3: ^0.0.2
```

## Usage

```dart
import 'package:youtube_api_v3/youtube_api_v3.dart';
YoutubeAPIv3 api = new YoutubeAPIv3({key});
/// List of videos from playlist
PlayListItemListResponse playlist = await api.playListItems2(
    playlistId:{playlistId},
    maxResults:{maxResults},
    part:Parts.{part});

List<PlayListItem> videos = playlist.items;
/// Next Page
PlayListItemListResponse page2 = await playlist.nextPage();
List<PlayListItem> videospage2 = page2.items;
```
