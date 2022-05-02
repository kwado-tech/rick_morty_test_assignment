import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_info.g.dart';

@JsonSerializable()
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

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);

  @override
  List<Object> get props => [count, pages, next!, previous!];

  @override
  String toString() {
    return 'PageInfo(count: $count, pages: $pages, next: $next, previous: $previous)';
  }
}
