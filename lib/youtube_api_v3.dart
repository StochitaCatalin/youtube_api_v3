library youtube_api_v3;

import 'dart:convert';

import 'package:http/http.dart';

class YoutubeAPIv3 {
  final String key;
  final String link = 'https://www.googleapis.com/youtube/v3/';
  YoutubeAPIv3(this.key);

  playListItems(playlistId,maxResult,part){
    return get(link+'playlistItems?playlistId='+playlistId+'&key='+key+'&maxResult='+maxResult.toString() +'&part='+part);
  }

  Future<PlayListItemListResponse> playListItems2(playlistId,maxResult,part){
    return
      get('${link}playlistItems?playlistId=${playlistId}&key=${key}&maxResult=${maxResult}&part=${part}')
        .then((response)=>
          PlayListItemListResponse.fromJson(jsonDecode(response.body)));
  }
}

class PlayListItemListResponse{
  final String kind;
  final String etag;
  final String nextPageToken;
  final PageInfo pageInfo;
  final List<PlayListItem> items;
  PlayListItemListResponse(this.kind,this.etag,this.nextPageToken,this.pageInfo,this.items);

  factory PlayListItemListResponse.fromJson(Map<String,dynamic> json){
    return PlayListItemListResponse(
      json['kind'],
      json['etag'],
      json['nextPageToken'],
      PageInfo.fromJson(json['pageInfo']),
      List<PlayListItem>.from(
        json['items'].map(
          (playListItem)=>
            PlayListItem.fromJson(playListItem)
        ).toList()
      )
    );
  }
}

class PageInfo{
  final int totalResults;
  final int resultsPerPage;

  PageInfo(this.totalResults,this.resultsPerPage);

  factory PageInfo.fromJson(Map<String,dynamic> json){
    return PageInfo(
      json['totalResults'],
      json['resultsPerPage']
    );
  }
}

class PlayListItem{
  final String kind;
  final String etag;
  final String id;
  final Snippet snippet;

  PlayListItem(this.kind,this.etag,this.id,this.snippet);
  factory PlayListItem.fromJson(Map<String,dynamic> json){
    return PlayListItem(
      json['kind'],
      json['etag'],
      json['id'],
      Snippet.fromJson(json['snippet'])
    );
  }
}

class Snippet{
  final String publishedAt;
  final String channelId;
  final String title;
  final String description;
  final Thumbnails thumbnails;
  final String channelTitle;
  final String playlistId;
  final int position;
  final ResourceId resourceId;

  Snippet(this.publishedAt,this.channelId,this.title,this.description,this.thumbnails,this.channelTitle,this.playlistId,this.position,this.resourceId);
  factory Snippet.fromJson(Map<String,dynamic> json){
    return Snippet(
      json['publishedAt'],
      json['channelId'],
      json['title'],
      json['description'],
      Thumbnails.fromJson(json['thumbnails']),
      json['channelTitle'],
      json['playlistId'],
      json['position'],
      ResourceId.fromJson(json['resourceId'])
    );
  }
}

class ResourceId{
  final String kind;
  final String videoId;
  ResourceId(this.kind,this.videoId);
  factory ResourceId.fromJson(Map<String,dynamic> json){
    return ResourceId(
      json['kind'],
      json['videoId']
    );
  }
}

class Thumbnails{
  final Thumbnail defaulT;
  final Thumbnail medium;
  final Thumbnail high;
  final Thumbnail standard;
  final Thumbnail maxres;

  Thumbnails(this.defaulT,this.medium,this.high,this.standard,this.maxres);
  factory Thumbnails.fromJson(Map<String,dynamic> json){
    return Thumbnails(
      Thumbnail.fromJson(json['default']),
      Thumbnail.fromJson(json['medium']),
      Thumbnail.fromJson(json['high']),
      Thumbnail.fromJson(json['standard']),
      Thumbnail.fromJson(json['maxres']),
    );
  }
}

class Thumbnail{
  final String url;
  final int width;
  final int height;

  Thumbnail(this.url,this.width,this.height);

  factory Thumbnail.fromJson(Map<String,dynamic> json){
    return Thumbnail(
      json['url'],
      json['width'],
      json['height']
    );
  }
}