// Declare all the constants

class AppConstants {
  static const String APP_NAME = 'Foody App';
  static const baseURL = "http://192.168.0.131:3000";
  static const googleApiKey = "AIzaSyDhbQKpuMh6m18t1RETNkVFNIcyyy-w3fQ";

  /*------------------------------AUTH----------------------------------------*/
  static const String EMAIL_LABEL = "Email Address";
  static const String EMAIL_HINT = "Enter emaill address";

  static const String USERNAME_LABEL = "Username";
  static const String USERNAME_HINT = "Enter username";

  static const String GENDER_LABEL = "Gender";
  static const String GENDER_MALE = "Male";
  static const String GENDER_FEMALE = "Female";

  static const String ADDRESS_LABEL = "Address";
  static const String ADDRESS_HINT = "Your house address";

  static const String PASSWORD_LABEL = "Password";
  static const String PASSWORD_HINT = "Enter password";

  static const String RETYPE_PASSWORD_LABEL = "Retype Password";
  static const String FORGET_PASSWORD_LABEL = "Forget Password?";

  static const String LOGIN_BUTTON_LABEL = "Login";
  static const String SIGNUP_BUTTON_LABEL = "Sign Up";
  static const String LOGOUT_BUTTON_LABEL = "Logout";

  static const String SUCCESSFUL_LOGIN_MSG = "Login Successully";
  static const String SUCCESSFUL_SIGNUP_MSG = "Sign Up Successully";
  static const String SUCCESSFUL_LOGOUT_MSG = "Logout Successully";

  /*--------------------------PROFILE_MODULE----------------------------------*/
  static const String PROFILE_TITLE = "My Profile";

  /*--------------------------NEWSFEED_MODULE----------------------------------*/
  static const String NEWSFEED_TITLE = "News Feed";

  /*------------------------MEET_AND_EAT_MODULE-------------------------------*/
  static const String MEET_AND_EAT_TITLE = "Meet and Eat";

  /*---------------------FRIEND_MANAGEMENT_MODULE-----------------------------*/
  static const String FRIEND_MANAGEMENT_TITLE = "Find Friends";

  /*----------------------MEAL_SUGGESTION_MODULE------------------------------*/
  static const String MEAL_SUGGESTION_TITLE = "Meal Suggestion";
  static const String LOCATION_LABLE = "Location";

  /*-------------------------CHAT_ROOM_MODULE---------------------------------*/
  static const String CHAT_ROOM_TITLE = "Message";

  /*----------------------------ERROR_MESSAGE---------------------------------*/
  static const String EMAIL_ERROR_MSG = "Invalid Email Address Format";
  static const String PASSWORD_ERROR_MSG =
      "Password must be at least 8 characters";
  static const String UNSUCCESSFUL_LOGIN_MSG = "Invalid credentials";
  static const String WEAK_NETWORK_ERROR_MSG = "Weak Internet Connection";
  static const String TRY_AGAIN_ERROR_MSG = "Please try again later";
}
