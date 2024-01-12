// import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/src/network/data/user/user_reference.dart';
import 'package:myapp/src/network/data/user/user_repository.dart';
import 'package:myapp/src/network/model/user/user.dart';

import '../../model/common/result.dart';

class UserRepositoryImpl extends UserRepository {
  final usersRef = UserReference();
  @override
  Future<MResult<MUser>> getUser(String id) async {
    try {
      final result = await usersRef.getUser(id);

      if (result.isSuccess) {
        final user = MUser(
          id: result.data!.id,
          email: result.data!.email,
          name: result.data!.name,
          avatar: result.data!.avatar,
          followers: result.data!.followers,
        );
        return MResult.success(user);
      }
      return MResult.error('Not user login');
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult> updateFollowers(
    String hostId,
    String followerId,
    bool isFollowed,
  ) async {
    return usersRef.updateFollowers(hostId, followerId, isFollowed);
  }

  @override
  Future<MResult<MUser>> getOrAddUser(MUser user) {
    return usersRef.getOrAddUser(user);
  }

  @override
  Future<MResult<List<MUser>>> getUsers() {
    return usersRef.getUsers();
  }

  Future<MResult<List<MUser>>> getUsersBySearch(String search, String userId,
      [MUser? lastUser]) async {
    return usersRef.getUsersBySearch(search, userId, lastUser);
  }

  Future<MResult<int>> getCountUsersBySearch(
    String search,
    String userId,
  ) async {
    return usersRef.getCountUsersBySearch(search, userId);
  }
}
