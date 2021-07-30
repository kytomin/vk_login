class VkUser {
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String photo50;
  late final String photo100;
  late final String photo200;
  late final String photo;
  late final String? maidenName;
  late final String? screenName;

  /// [sex] if value is 1 - female, 2 - male, 0 - gender not specified
  late final int sex;

  ///[relation] if value is 1 - not married,
  /// 2 - have a boyfriend / girlfriend,
  /// 3 - engaged,
  /// 4 - married ,
  /// 5 - it's Complicated,
  /// 6 - actively looking,
  /// 7 - in love,
  /// 9 - in a civil marriage,
  /// 0 - not specified,
  late final int relation;

  late final int? relationPartnerId;

  /// [relationPending] if value is 1 - partner did not confirm the relationship
  late final int? relationPending;

  late final List<int>? relationRequestsIds;

  /// [birthDate] in format D.M.YYYY
  late final String birthDate;

  /// [birthDateVisibility] if value is 1 - show date of birth,
  /// 2 - show only month and day,
  /// 0 - do not show date of birth
  late final int birthDateVisibility;

  late final String homeTown;

  late final int? countryId;
  late final String? countryTitle;

  late final int? cityId;

  late final String? cityTitle;

  late final String status;

  late final String phone;

  /// [accountGetProfileInfo] is a response from account.getProfileInfo
  /// [usersGet] is a response from users.get with photo_50,photo_100,photo_200,photo_max_orig params
  VkUser.fromJSON(accountGetProfileInfo, usersGet) {

    this.id = accountGetProfileInfo['id'];
    this.photo50 = usersGet['photo_50'];
    this.photo100 = usersGet['photo_100'];
    this.photo200 = usersGet['photo_200'];
    this.photo = usersGet['photo_max_orig'];
    this.firstName = accountGetProfileInfo['first_name'];
    this.lastName = accountGetProfileInfo['last_name'];
    this.maidenName = accountGetProfileInfo['maiden_name'];
    this.screenName = accountGetProfileInfo['screen_name'];
    this.sex = accountGetProfileInfo['sex'];
    this.relation = accountGetProfileInfo['relation'];
    this.relationPartnerId = accountGetProfileInfo['relation_partner'] != null ? accountGetProfileInfo['relation_partner']['id'] : null;
    this.relationPending = accountGetProfileInfo['relation_pending'];
    this.birthDate = accountGetProfileInfo['bdate'];
    this.birthDateVisibility = accountGetProfileInfo['bdate_visibility'];
    this.countryId = accountGetProfileInfo['country'] != null ? accountGetProfileInfo['country']['id'] : null;
    this.countryTitle = accountGetProfileInfo['country'] != null ? accountGetProfileInfo['country']['title'] : null;
    this.homeTown = accountGetProfileInfo['home_town'];
    this.cityId = accountGetProfileInfo['city']?['id'];
    this.cityTitle = accountGetProfileInfo['city'] != null ? accountGetProfileInfo['city']['title'] : null;
    this.status = accountGetProfileInfo['status'];
    this.phone = accountGetProfileInfo['phone'];
  }

  @override
  String toString() {
    return 'VkUser(id: $id, firstName:$firstName, lastName:$lastName)';
  }
}
