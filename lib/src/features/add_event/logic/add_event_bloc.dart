import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/dialogs/alert_wrapper.dart';
import 'package:myapp/src/dialogs/toast_wrapper.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';

import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';

import 'package:myapp/src/router/coordinator.dart';

class AddEventBloc extends Cubit<AddEventState> {
  AddEventBloc() : super(AddEventState.ds());

  final DomainManager domain = DomainManager();
  PageController controller = PageController(initialPage: 0);
  MapController mapController = MapController();

  void setCurrentPage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void selectMedias() async {
    final ImagePicker picker = ImagePicker();
    List<XFile> pickMedias = await picker.pickMultiImage(imageQuality: 5);

    if (state.medias.length < 5) {
      List<XFile?> newMedias = [...pickMedias, ...state.medias];
      if (newMedias.length > 5) {
        newMedias = [...newMedias.sublist(0, 5)];
      }
      emit(state.copyWith(medias: newMedias));
    } else {
      if (pickMedias.length > 5) {
        pickMedias = [...pickMedias.sublist(0, 5)];
      }
      emit(state.copyWith(medias: [...pickMedias]));
    }
  }

  void removeImage(int index) {
    final List<XFile?> newMedias = state.medias;
    newMedias.removeAt(index);
    emit(state.copyWith(medias: newMedias));
  }

  void handleTap(point) {
    emit(state.copyWith(selectedLocation: point));
  }

  void setNameEvent(value) {
    emit(state.copyWith(nameEvent: value));
  }

  void setDescriptionEvent(value) {
    emit(state.copyWith(description: value));
  }

  void setNumberMemberEvent(value) {
    emit(state.copyWith(numberMember: value));
  }

  void setStartDateEvent(value) {
    emit(state.copyWith(startDate: value));
  }

  void setDeadlineEvent(value) {
    emit(state.copyWith(deadlineDate: value));
  }

  void setTimeEvent(value) {
    emit(state.copyWith(time: value));
  }

  void setType(TypeEvent type) {
    emit(state.copyWith(typeEvent: type));
  }

  void addEvent() async {
    if (!isClosed) emit(state.copyWith(isPosting: true));

    List<String> images = state.medias.map((e) => e!.path).toList();
    DateTime startDate = DateTime(
      state.startDate!.year,
      state.startDate!.month,
      state.startDate!.day,
      state.time!.hour,
      state.time!.minute,
    );
    final MEvent event = MEvent(
      name: state.nameEvent,
      description: state.description,
      images: images,
      startDate: startDate,
      type: state.typeEvent,
      deadline: state.deadlineDate,
      location: state.selectedLocation,
      maxAttendee: state.numberMember,
      host: GetIt.I<AccountBloc>().state.user,
      favoritesId: [],
      followersId: [],
    );

    final result = await domain.event.addEvent(event);

    if (!isClosed) emit(state.copyWith(isPosting: false));

    if (result.isSuccess) {
      AppCoordinator.pop();
      XToast.success('Create event success');
    } else {
      XAlert.show(title: 'Create event fail', body: result.error);
    }
  }

  @override
  Future<void> close() {
    mapController.dispose();
    controller.dispose();
    return super.close();
  }
}
