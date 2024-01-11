// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myapp/src/network/model/event/event.dart';

class AddStoryState {
  List<MEvent>? events;
  bool isPosting;

  XFile? image;
  MEvent? event;
  AddStoryState({
    this.image,
    this.event,
    this.events,
    this.isPosting = false,
  });

  AddStoryState copyWith({
    List<MEvent>? events,
    bool? isPosting,
    XFile? image,
    MEvent? event,
  }) {
    return AddStoryState(
      events: events ?? this.events,
      isPosting: isPosting ?? this.isPosting,
      image: image ?? this.image,
      event: event ?? this.event,
    );
  }

  bool checkCondition() {
    if (image != null && event != null) return true;
    return false;
  }

  @override
  bool operator ==(covariant AddStoryState other) {
    if (identical(this, other)) return true;

    return listEquals(other.events, events) &&
        other.isPosting == isPosting &&
        other.image == image &&
        other.event == event;
  }

  @override
  int get hashCode {
    return events.hashCode ^
        isPosting.hashCode ^
        image.hashCode ^
        event.hashCode;
  }
}
