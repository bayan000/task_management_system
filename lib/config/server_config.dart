

class ServerConfig{

  static String  domainName='http://192.168.43.139:8000/';
  //task
  static String deleteTask='api/admin/task/delete/';
  static String showTasks='api/show/MyTask';
  static String showOneTask='api/show/details/';
  static String showCompletedTasks='api/show/completed/tasks';
  static String showMissedTasks='api/show/missed/tasks';
  static String  showOnProgressTasks='api/show/progress/tasks';
  static String showToDoTasks='api/show/progress/tasks';
  static String editTask='api/admin/task/update/';
  static String SearchOfTask='api/search/task';
  static String addTask='api/admin/task/add';
  //calendar
  static String addEvent='api/add/event';
  static String editEvent='api/edit/event/';
  static String deleteEvent='api/delete/event/';
  static String showMyEvents='api/show/events';
  static String showOneEvent='api/show/event/';
  //user
  static String editUser='api/admin/user/update/';
  static String deleteUser='api/admin/user/delete/';
  static String showUsers='api/admin/user/show/users';
  static String updateUser = "api/admin/user/update/";
  static String login='api/auth/login';
  static String logout='api/logout';
  static String addUser='api/admin/user/add';
  //report
  static String showReports='api/show/report/';
  //team
  static String addTeam='api/admin/department/add';
  static String editTeam='api/admin/department/update/';
  static String deleteTeam='api/admin/department/delete/';
  static String showTeams='api/admin/department/show/team';
  static String showAteam='api/admin/department/show/team/';
  static String teamName='api/admin/department/show/team/name/';
  //meeting
  static String addMeeting='api/admin/meeting/add';
  static String editMeeting='api/admin/meeting/update/';
  static String meetingStates='api/show1';
  static String showMeetings='api/show/MyMeeting';
  static String stateName='api/show1/name/';
  static String deleteMeeting='api/admin/meeting/delete/';
  static String showMeeting='api/show/OneMeeting/';
  static String myTeam='api/show/MyTeam';
  //acheiver
  static String acheivers='api/achiever/show/';
  //subtask
  static String showSubtask='api/show/one/subtask/';

 // static String addSubtask='api/leader/task/1/subtask/create';
  //status for subatsk
  static String showSubStatuses='api/show2';
  //priority for subatsk
  static String showSubPriorites='api/show3';
}