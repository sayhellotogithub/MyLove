import 'dart:convert' show json;

import 'package:mylove/model/base_model.dart';
import 'package:mylove/model/list_model.dart';

class ArticleModel extends BaseModel<ListModel<Article>> {

  ArticleModel.fromParams({errorCode, errorMsg, data});

  factory ArticleModel(jsonStr) =>
      jsonStr == null ? null : jsonStr is String ? new ArticleModel.fromJson(
          json.decode(jsonStr)) : new ArticleModel.fromJson(jsonStr);

  ArticleModel.fromJson(jsonRes){
    BaseModel.jsonToModel(this, jsonRes);
    data = jsonRes["data"]["data"] == null ? null : new ListModel.fromJson(
        jsonRes["data"]["data"], (item) {
      return item == null ? null : new Article.fromJson(item);
    });
  }
}


class Article {

  int chapterId;
  int courseId;
  int id;
  int publishTime;
  int superChapterId;
  int type;
  int userId;
  int visible;
  int zan;
  bool collect;
  bool fresh;
  String apkLink;
  String author;
  String chapterName;
  String desc;
  String envelopePic;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  String superChapterName;
  String title;
  List<Tag> tags;

  Article.fromParams(
      {this.chapterId, this.courseId, this.id, this.publishTime, this.superChapterId, this.type, this.userId, this.visible, this.zan, this.collect, this.fresh, this.apkLink, this.author, this.chapterName, this.desc, this.envelopePic, this.link, this.niceDate, this.origin, this.projectLink, this.superChapterName, this.title, this.tags});

  Article.fromJson(jsonRes) {
    chapterId = jsonRes['chapterId'];
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    publishTime = jsonRes['publishTime'];
    superChapterId = jsonRes['superChapterId'];
    type = jsonRes['type'];
    userId = jsonRes['userId'];
    visible = jsonRes['visible'];
    zan = jsonRes['zan'];
    collect = jsonRes['collect'];
    fresh = jsonRes['fresh'];
    apkLink = jsonRes['apkLink'];
    author = jsonRes['author'];
    chapterName = jsonRes['chapterName'];
    desc = jsonRes['desc'];
    envelopePic = jsonRes['envelopePic'];
    link = jsonRes['link'];
    niceDate = jsonRes['niceDate'];
    origin = jsonRes['origin'];
    projectLink = jsonRes['projectLink'];
    superChapterName = jsonRes['superChapterName'];
    title = jsonRes['title'];
    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']) {
      tags.add(tagsItem == null ? null : new Tag.fromJson(tagsItem));
    }
  }

  @override
  String toString() {
    return '{"chapterId": $chapterId,"courseId": $courseId,"id": $id,"publishTime": $publishTime,"superChapterId": $superChapterId,"type": $type,"userId": $userId,"visible": $visible,"zan": $zan,"collect": $collect,"fresh": $fresh,"apkLink": ${apkLink !=
        null ? '${json.encode(apkLink)}' : 'null'},"author": ${author != null
        ? '${json.encode(author)}'
        : 'null'},"chapterName": ${chapterName != null ? '${json.encode(
        chapterName)}' : 'null'},"desc": ${desc != null
        ? '${json.encode(desc)}'
        : 'null'},"envelopePic": ${envelopePic != null ? '${json.encode(
        envelopePic)}' : 'null'},"link": ${link != null
        ? '${json.encode(link)}'
        : 'null'},"niceDate": ${niceDate != null
        ? '${json.encode(niceDate)}'
        : 'null'},"origin": ${origin != null
        ? '${json.encode(origin)}'
        : 'null'},"projectLink": ${projectLink != null ? '${json.encode(
        projectLink)}' : 'null'},"superChapterName": ${superChapterName != null
        ? '${json.encode(superChapterName)}'
        : 'null'},"title": ${title != null
        ? '${json.encode(title)}'
        : 'null'},"tags": $tags}';
  }
}

class Tag {

  String name;
  String url;

  Tag.fromParams({this.name, this.url});

  Tag.fromJson(jsonRes) {
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"name": ${name != null
        ? '${json.encode(name)}'
        : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

