 

 
import 'package:akalpit/features/clubProfile/services/utils/roleenum.dart';

class ClubRoleHelper {
  static bool canEditClub(ClubRole role) {
    return role == ClubRole.owner || role == ClubRole.admin;
  }

  static bool canManageMembers(ClubRole role) {
    return role == ClubRole.owner || role == ClubRole.admin;
  }

  static bool canPost(ClubRole role) {
    return role == ClubRole.owner ||
           role == ClubRole.admin ||
           role == ClubRole.member;
  }

  static bool canViewPrivateClub(ClubRole role) {
    return role != ClubRole.none;
  }
}
