library globals.UserSession;

bool isLogggedIn = false;
String username = "";

var back = "http://localhost:8080";

var authUrl = back + "/auth";
var usersUrl = back + "/admin/user";
var missionUrl = back + "/prototype/mission/";
var mailUrl = back + "/prototype/mail/";
var deleteUsersUrl = back + "/prototype/delete-user/";
var loadUsersUrl = back + "/prototype/users/";
var clonePrototypeUrl = back + "/admin/clone-prototype/";
var inviteUsersUrl = back + "/admin/invite-all";
var welcomeAllUrl = back + "/admin/welcome-all";
var companyUrl = back + "/prototype/company/";
var reportingUrl = back + "/reporting/";
var dataminingUrl = back + "/data-mining/";
var pingUrl = back + "/ping";