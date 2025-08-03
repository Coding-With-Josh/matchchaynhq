abstract final class RouteDestinations {
  //top level routes
  static const splash = "/";
  static const getStarted = "/get-started";

  static const verifyEmailRelative = "verify-email";

  //signup routes
  static const signUp = "/sign-up";
  static const setPasswordRelative = "set-password";
  static const setPassword = "$signUp/$setPasswordRelative";
  static const verifyEmailFromSignUp = "$signUp/$verifyEmailRelative";

  //onboarding
  static const userProfileOnboarding = "/user-profile-onboarding";
  static const faceVerification = "/face-verification";

  //auth
  static const login = "/login";
  static const forgotPassword = "/forgot-password";
  static const createNewPassword = "/create-new-password";
  static const verifyEmailFromForgotPassword =  "$forgotPassword/$verifyEmailRelative";


  //bottom nav destinations
  static const home = "/home";
  static const profile = "/profile";
  static const likes = "/likes";
  static const messages = "/messages";

  //notifications
  static const notifications = "/notifications";
  static const notificationsRelative = "notifications";

  //moments
  static const moments = "/moments";
  static const momentsRelative = "moments";

  //messageChat
  static const chatScreenRelative = "message-chat";
  static const chatScreen = "$messages/$chatScreenRelative";

  //calls
  static const callRelative = "call";
  static const calls = "$messages/$callRelative";

  //premium
  static const premium = "/premium";
  static const premiumRelative = "premium";


}
