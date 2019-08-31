library youtube_api_v3;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

enum Parts{snippet,contentDetails,id,status}

class YoutubeAPIv3 {
  final String key;
  YoutubeAPIv3(this.key);

  static String linkFromParams(Map<String,dynamic> params){
    return params.keys.map((key){
      if(params[key] is Parts){
        String partValue = params[key].toString().split('.').last;
        return '$key=$partValue';
      }
      return '$key=${params[key]}';
    }).join('&');
  }

  Future<PlayListItemListResponse> playListItems({@required String playlistId,@required int maxResults,@required Parts part}){
    Map<String,dynamic> params = new Map();
    params['key'] = key;
    params['playlistId'] = playlistId;
    params['maxResults'] = maxResults;
    params['part'] = part;
    return playListItemsParams(params);
  }

  static Future<PlayListItemListResponse> playListItemsParams(Map<String,dynamic> params){
    return
      get('https://www.googleapis.com/youtube/v3/playlistItems?${linkFromParams(params)}')
        .then((response)=>
          PlayListItemListResponse.fromJson(params,jsonDecode(response.body)));
  }
}

class PlayListItemListResponse{
  final Map<String,dynamic> params;
  final String kind;
  final String etag;
  final String prevPageToken;
  final String nextPageToken;
  final PageInfo pageInfo;
  final List<PlayListItem> items;
  PlayListItemListResponse(this.params,this.kind,this.etag,this.prevPageToken,this.nextPageToken,this.pageInfo,this.items);

  prevPage(){
    if(prevPageToken == null)
      throw('No prev page!');
    params['pageToken'] = prevPageToken;
    return YoutubeAPIv3.playListItemsParams(params);
  }

  nextPage(){
    if(nextPageToken == null)
      throw('No next page!');
    params['pageToken'] = nextPageToken;
    return YoutubeAPIv3.playListItemsParams(params);
  }

  factory PlayListItemListResponse.fromJson(Map<String,dynamic> params,Map<String,dynamic> json){
    return PlayListItemListResponse(
      params,
      json['kind'],
      json['etag'],
      json['prevPageToken'],
      json['nextPageToken'],
      PageInfo.fromJson(json['pageInfo']),
      List<PlayListItem>.from(
        json['items'].map(
          (playListItem)=>
            PlayListItem.fromJson(playListItem,params['part'])
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
  final ContentDetails contentDetails;
  final Status status;

  PlayListItem(this.kind,this.etag,this.id,this.snippet,this.contentDetails,this.status);
  factory PlayListItem.fromJson(Map<String,dynamic> json,Parts part){
    return PlayListItem(
      json['kind'],
      json['etag'],
      json['id'],
      part == Parts.snippet ? Snippet.fromJson(json['snippet']) : null,
      part == Parts.contentDetails ? ContentDetails.fromJson(json['contentDetails']) : null,
      part == Parts.status ? Status.fromJson(json['status']) : null
    );
  }
}

class ContentDetails{
  final String videoId;
  final String videoPublishedAt;

  ContentDetails(this.videoId,this.videoPublishedAt);

  factory ContentDetails.fromJson(Map<String,dynamic> json){
    return ContentDetails(
      json['videoId'],
      json['videoPublishedAt']
    );
  }
}

class Status{
  final String privacyStatus;

  Status(this.privacyStatus);

  factory Status.fromJson(Map<String,dynamic> json){
    return Status(
      json['privacyStatus']
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