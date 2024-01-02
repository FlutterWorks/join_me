import 'package:latlong2/latlong.dart';
import 'package:myapp/src/network/model/common/pagination/meta/pagination_meta.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

List<MEvent> listEvent = [
  MEvent(
    id: '1',
    name: "Happy birthday",
    description: "this is description",
    images: ["assets/images/images/bg-event.jpg"],
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    province: 'Ho Chi Minh',
    location: LatLng(88.00015, 85.1316546),
    host: const MUser(
        id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
    follower: 122,
    type: 'sport',
  ),
  MEvent(
    id: '2',
    name: "Halloween",
    description: "this is description",
    images: ["assets/images/images/bg-event.jpg"],
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    province: 'Ho Chi Minh',
    location: LatLng(88.00015, 85.1316546),
    host: const MUser(
        id: '2', name: 'Kien Vo', avatar: "assets/images/images/avatar.png"),
    follower: 122,
    type: 'sport',
  ),
  MEvent(
    id: '3',
    name: "Sunday",
    description: "this is description",
    images: ["assets/images/images/bg-event.jpg"],
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    province: 'Ho Chi Minh',
    location: LatLng(88.00015, 85.1316546),
    host: const MUser(
        id: '2', name: 'Kien Vo', avatar: "assets/images/images/avatar.png"),
    follower: 122,
    type: 'sport',
  ),
  MEvent(
    id: '4',
    name: "Merry",
    description: "this is description",
    images: ["assets/images/images/bg-event.jpg"],
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    province: 'Ho Chi Minh',
    location: LatLng(88.00015, 85.1316546),
    host: const MUser(
        id: '2', name: 'Kien Vo', avatar: "assets/images/images/avatar.png"),
    follower: 122,
    type: 'sport',
  ),
];

class EventRepositoryMock {
  MResult<MEvent> getEvent(String id) {
    final MEvent result = MEvent.ds(id: '1', host: MUser.empty());
    return MResult.success(result);
  }

  MResult<List<MEvent>> getEventsSearch(String search) {
    if (search == "") return MResult.success([]);
    final result = listEvent
        .where((element) =>
            element.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return MResult.success(result);
  }

  MResult<MPaginationResponse<MEvent>> getEventsByUser(String userId) {
    final List<MEvent> events = listEvent;
    final result = MPaginationResponse(
      data: events,
      meta: const MPaginationMeta(
        pageSize: MPagination.defaultPageLimit,
        totalCount: 50,
        pageNumber: 4,
        lastPage: 5,
      ),
    );
    return MResult.success(result);
  }
}
