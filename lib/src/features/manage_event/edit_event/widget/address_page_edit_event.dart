import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_bloc.dart';
import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_state.dart';
import 'package:myapp/src/theme/colors.dart';

class AddressPageEditEvent extends StatelessWidget {
  const AddressPageEditEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditEventBloc, EditEventState>(
        buildWhen: (previous, current) =>
            previous.event.location != current.event.location,
        builder: (context, state) {
          return Container(
            color: AppColors.white,
            child: Column(
              children: [
                const Text(
                  "Select location",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (state.event.location != null)
                  Expanded(
                      child: GoogleMap(
                    mapType: MapType.terrain,
                    onMapCreated: context.read<EditEventBloc>().onMapCreate,
                    initialCameraPosition: CameraPosition(
                      target: state.event.location!,
                      zoom: 16,
                    ),
                    onTap: (argument) {
                      context.read<EditEventBloc>().handlePressMap(argument);
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId('my location'),
                        position: state.event.location!,
                      )
                    },
                  )),
              ],
            ),
          );
        });
  }
}
