import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character extends Equatable {
  final String name;
  final String image;

  Character(this.name, this.image);

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  @override
  List<Object> get props => [name, image];

  @override
  String toString() => 'Character(name: $name, image: $image)';
}

class PageInfo extends Equatable {
  final int count;
  final int pages;
  final String? next;
  final String? previous;

  const PageInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.previous,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      previous: json['previous'],
    );
  }

  @override
  List<Object> get props => [count, pages, next!, previous!];

  @override
  String toString() {
    return 'PageInfo(count: $count, pages: $pages, next: $next, previous: $previous)';
  }
}

class CharacterList extends Equatable {
  final PageInfo info;
  final List<Character> characters;

  const CharacterList._({required this.info, required this.characters});

  factory CharacterList.fromJson(Map<String, dynamic> json) {
    return CharacterList._(
      info: PageInfo.fromJson(json['info']),
      characters: (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object> get props => [info, characters];

  @override
  String toString() => 'CharacterList(info: $info, characters: $characters)';
}
