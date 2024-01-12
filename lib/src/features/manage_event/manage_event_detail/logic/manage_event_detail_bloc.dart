import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/router/coordinator.dart';

class ManageEventDetailBloc extends Cubit<ManageEventDetailState> {
  ManageEventDetailBloc({required eventId})
      : super(ManageEventDetailState.ds()) {
    getData(eventId);
  }
  PageController controller = PageController();
  GoogleMapController? mapController;
  DomainManager domain = DomainManager();

  void getData(String eventId) async {
    await getEvent(eventId);
    await getFollowers(eventId);
  }

  void onMapCreate(GoogleMapController controller) {
    mapController ??= controller;
  }

  Future<void> getEvent(String eventId) async {
    try {
      final result = await domain.event.getEvent(eventId);
      if (result.isSuccess) {
        MEvent event = result.data!;
        emit(state.copyWith(event: event));
      }
    } catch (e) {
      print(e);
    }
  }

  void goEditEvent(String eventId) async {
    final event = await AppCoordinator.showEditEventScreen(id: eventId);
    emit(state.copyWith(event: event as MEvent?));
  }

  void backScreen() {
    AppCoordinator.pop(state.event);
  }

  Future<void> getFollowers(String eventId) async {
    try {
      final result =
          await domain.user.getUsersByIds(state.event.followersId ?? []);
      if (result.isSuccess) {
        final List<MUser> followers = result.data!;
        emit(state.copyWith(followers: followers));
      }
    } catch (e) {
      print(e);
    }
  }

  void setIndexPageImage(int value) {
    emit(state.copyWith(indexPageImage: value));
  }

  @override
  Future<void> close() async {
    controller.dispose();
    mapController?.dispose();
    super.close();
  }
}
