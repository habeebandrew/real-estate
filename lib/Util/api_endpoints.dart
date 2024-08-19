import 'package:pro_2/Util/cache_helper.dart';

class ApiAndEndpoints {
   static const api = 'http://192.168.1.102:8000/api/';
  // static Future<String> getApi() async {
  //   String? ip = await CacheHelper.getString(key: 'ip');
  //   return 'http://192.168.1.104:8000/api/';
  // }

  // static Future<String> api = getApi();
//*HABEEB:   192.168.1.106
  static const verify = 'verifyEmail'; //register
  static const showAuctions = 'showAuctions';
  static const auctionid = 'auction/';
  static const auctionParticipants = 'auctionParticipants/';
  static const showSharingTimePropertyInListHome =
      'showSharingTimePropertyInListHome';

  static const addParticipate = 'addParticipate';

  static const signUp = 'register'; //verifyEmail
  static const checkCode = 'checkCode'; //register

  static const logIn = 'signIn';

  static const logout = 'logOut';

  static const createpost = 'posts';
  static const getpost = 'posts';
  static const get_My_Post = 'my-posts';

  static const updateRole = 'updateRole';
  static const addComment = 'addComment';
  static const getComments = 'comments?';
  static const reports = 'reports';

  static const getFavourite = 'showPropertiesInList';

  static const addFavourite = 'favorites';

  //for delete addaFavourite+deleteFavourite
  static const deleteFavourite = '/delete?';
  static const editProfile = 'editProfile'; //number or pic for user?
  // static const showMyImage = 'showMyImage'; //pic for user
  static const addPropertyAd = 'addPropertyAd';
  static const fetchAllAddresses = 'fetchAllAddresses?governorate_id=';
  static const addSharingTimeProperty = 'addSharingTimeProperty';

  static const showSharingTimePropertyDetails =
      'showSharingTimePropertyDetails?sharingTimeProperty_id=';

  static const getProperty = 'showPropertiesInListHome?user_id=';
  static const getBrokerProperties = 'showPropertyForBroker?user_id=';
  static const getPropertyDetails = 'showAllDetailsProperty?property_id=';
  //filter in home filterProperty+what you want to filter
  // if you want all of them like for advanced search filterPropertyType&filterGovernorate&filterStatus
  static const filterProperty = 'filters?';
  static const filterPropertyType = 'property_type_id=';
  static const filterGovernorate = 'governorate_id=';
  static const filterStatus = 'status_id=';
  static const getBrokerInfo = 'showBrokerProfile?brokerId=';

  static const rate = 'evaluations';
  static const contacts = 'contacts';
  static const inquiries = 'inquiries';
  static const showCountMyNotification = 'showCountMyNotification';
  static const showMyImage = 'showMyImage';

  static const showMyNotifications = 'showMyNotifications';
  static const forgotPassword = 'forgotPassword';

  static const updatePassword = 'updatePassword';

  static const showAllImagesProperty = 'show360ImagesProperty';

  static const advancedSearch = 'advancedSearch?';

  static const subscribe = 'payment';

  static const subscribeDetails = 'getMySub';
}
