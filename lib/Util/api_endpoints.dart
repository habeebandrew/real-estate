class ApiAndEndpoints {
  static const api = 'http://192.168.1.103:8000/api/';

//*HABEEB:   192.168.1.106
  static const signUp = 'register';

  static const logIn = 'signIn';

  static const logout = 'logOut';

  static const createpost = 'posts';
  static const getpost = 'posts';
  static const get_My_Post = 'my-posts';

  static const updateRole = 'updateRole';
  static const addComment = 'addComment';
  static const getComments = 'comments?';
  static const reports_post = 'reports';


  static const getFavourite = 'showPropertiesInList';

  static const addFavourite = 'favorites';

  //for delete addaFavourite+deleteFavourite
  static const deleteFavourite = '/delete?';
  static const editProfile = 'editProfile'; //number or pic for user?
  static const showMyImage = 'showMyImage'; //pic for user
  static const addPropertyAd = 'addPropertyAd';
  static const fetchAllAddresses = 'fetchAllAddresses?governorate_id=';

  static const getProperty = 'showPropertiesInListHome?user_id=';
  static const getPropertyDetails = 'showAllDetailsProperty?property_id=';

  //filter in home filterProperty+what you want to filter
  // if you want all of them like for advanced search filterPropertyType&filterGovernorate&filterStatus
  static const filterProperty = 'filters?';
  static const filterPropertyType = 'property_type_id=';
  static const filterGovernorate = 'governorate_id=';
  static const filterStatus = 'status_id=';
}
