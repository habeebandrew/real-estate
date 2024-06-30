class ApiAndEndpoints{

 static const api = 'http://192.168.1.106:8000/api/';
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

 static const getFavourite = 'showPropertiesInList';

 static const  addFavourite ='favorites';
 //for delete addaFavourite+deleteFavourite
 static const deleteFavourite = '/delete?';
 static const editProfile = 'editProfile';//number or pic for user?
 static const showMyImage = 'showMyImage';//pic for user
 static const addPropertyAd = 'addPropertyAd';
 static const  fetchAllAddresses = 'fetchAllAddresses?governorate_id=';


}