import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tracker/controllers/add_meeting_controller.dart';
import 'package:tracker/controllers/add_subtask_controller.dart';
import 'package:tracker/controllers/edit_meeting_controller.dart';
import 'package:tracker/controllers/login_controller.dart';
import 'package:tracker/controllers/profile_controller.dart';
import 'package:tracker/controllers/show_team_controller.dart';
import 'package:tracker/controllers/statistics.dart';
import 'package:tracker/controllers/task_controller.dart';
import 'package:tracker/controllers/teams_controller.dart';
import 'package:tracker/controllers/user_controller.dart';
import 'package:tracker/modules/acheivers/acheivers.dart';
import 'package:tracker/modules/add%20meeting/add_meeting.dart';
import 'package:tracker/modules/statistics/member_statistics.dart';
import 'package:tracker/modules/subtask/add_subtask.dart';
import 'package:tracker/modules/user/add_user.dart';
import 'package:tracker/modules/calendar/calendar_screen.dart';
import 'package:tracker/modules/comments/comments.dart';
import 'package:tracker/modules/edit%20team/edit_team.dart';
import 'package:tracker/modules/subtask/edit_subtask.dart';
import 'package:tracker/modules/user/edit_user.dart';
import 'package:tracker/modules/meeting/MeetingForLeader.dart';
import 'package:tracker/modules/meetings/leaders_meetings.dart';
import 'package:tracker/modules/meetings/meetings.dart';
import 'package:tracker/modules/reports/reports.dart';
import 'package:tracker/modules/edit_meeting/selectUsers.dart';
import 'package:tracker/modules/add_meeting/select_to_add.dart';
import 'package:tracker/modules/subtask/l_sub_task.dart';
import 'package:tracker/modules/team/my_team_l.dart';
import 'package:tracker/modules/team/my_team_m.dart';
import 'package:tracker/modules/subtask/select_to_edit.dart';
import 'package:tracker/modules/teams/teams.dart';
import 'package:tracker/modules/user/user.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/add_team_provider.dart';
import 'package:tracker/controllers/edit_team_provider.dart';
import 'package:tracker/shared/constants.dart';
import 'controllers/attachment_controller.dart';
import 'controllers/calendar_controller.dart';
import 'controllers/edit_subtask_controller.dart';
import 'controllers/meetings_controller.dart';
import 'controllers/notifications.dart';
import 'modules/add team/add_team.dart';
import 'modules/attachment/add_attachment.dart';
import 'modules/attachment/leader_attaschments.dart';
import 'modules/dashboard/member_dashboard.dart';
import 'modules/notification/notifications.dart';
import 'modules/profile/add_profile.dart';
import 'modules/profile/edit_profile.dart';
import 'modules/profile/m_add_profile.dart';
import 'modules/profile/m_edit_profile.dart';
import 'modules/profile/m_profile_screen.dart';
import 'modules/profile/profile_screen.dart';
import 'modules/subtask/select_onTeam_l.dart';
import 'modules/tasks/add_task.dart';
import 'modules/calendar/all_events.dart';
import 'modules/dashboard/dashboard.dart';
import 'modules/dashboard/leader_dashboard.dart';
import 'modules/edit meeting/edit_meeting.dart';
import 'modules/calendar/edit_event.dart';
import 'modules/tasks/edit_task.dart';
import 'modules/auth/login_screen.dart';
import 'modules/meeting/meeting.dart';
import 'modules/tasks/leader_tasks_screen.dart';
import 'modules/tasks/member_tasks_screen.dart';
import 'modules/tasks/search.dart';
import 'modules/statistics/statistics.dart';
import 'modules/subtask/a_subtask.dart';
import 'modules/subtask/m_subtask.dart';
import 'modules/tasks/task_details.dart';
import 'modules/tasks/task_details_for_leader.dart';
import 'modules/tasks/tasks_screen.dart';
import 'modules/team/team.dart';
import 'modules/user/users.dart';
void main() async {
  await GetStorage.init();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) =>AddTeamProvider()),
      ChangeNotifierProvider(create: (_) =>EditTeamProvider()),
      ChangeNotifierProvider(create: (_)=> LoginController()),
      ChangeNotifierProvider(create: (_)=> AddMeetingProvider()),
      ChangeNotifierProvider(create: (_)=> TeamsController()),
      ChangeNotifierProvider(create: (_)=> EditMeetingProvider()),
      ChangeNotifierProvider(create: (_)=> ShowTeamController()),
      ChangeNotifierProvider(create: (_)=> MeetingsController()),
      ChangeNotifierProvider(create: (_)=> UserController()),
      ChangeNotifierProvider(create: (_)=> AddSubtaskProvider()),
      ChangeNotifierProvider(create: (_)=> EditSubtaskProvider()),
      ChangeNotifierProvider(create: (_)=> TaskController()),
      ChangeNotifierProvider(create: (_)=> MyCalendarCont()),
      ChangeNotifierProvider(create: (_)=> StatisticsController()),
      ChangeNotifierProvider(create: (_) =>AttachementController()),
      ChangeNotifierProvider(create: (_) => NotificationController()),
      ChangeNotifierProvider(create: (_) => ProfileController()),

    ],
    child: MyApp(),)
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    int role_id = GetStorage().read(
        'role_id');
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: appName,

      initialRoute:GetStorage().hasData('token') ?
          role_id==1?
          '/Dashboard':
          role_id==2?
          '/DashboardTeamLeader':
          '/DashboardMember'
                                                  :
      '/login',
      builder: EasyLoading.init(),
      routes:
      {
        '/login': (context) => Login(),

//Admin**************************************
        '/Dashboard': (context) => Dashboard(),
        '/teams':(context){return  Teams();},
        '/Users':(context) => Users(),
        '/Report':(context){return const Reports();},
        '/TaskScre': (context) => TaskScre(),
        '/PageCalendar':(context)=>PageCalendar(),
        '/meetings':(context){return  Meetings();},
        '/StatisticsScre':(context)=>StatisticsScre(),
        '/SearchPage':(context)=>SearchPage(),
        '/AddTask':(context) => AddTask(),
        '/EditUser':(context) => EditUser(),
        '/TaskDetail':(context)=>TaskDetail(),
        '/add_team':(context){return const AddTeam();},
        '/add_meeting':(context){return AddMeeting();},
        '/AddUser':(context){return  AddUser();},
        '/edit_meeting':(context){return EditMeeting();},
        '/edit_team':(context){return EditTeam();},
        '/meeting':(context){return Meeting();},
        '/team':(context){return Team();},
        '/a_subtask':(context){return ASubTask();},
        '/select_users':(context){return  SelectUsers();},
        '/select_to_add_users':(context){return  SelectToAddUsers();},
        '/EditTask':(context)=>EditTask(),
        '/acheivers':(context){return  Acheivers();},
        '/AllEvents':(context)=>AllEvents(),
        '/EditEvent':(context)=>EditEventScr(),
        '/user':(context){return  UserScreen();},

//profile**leader&member**********************
        '/AddProfile':(context)=>AddProfile(),
        '/ProfileScr':(context)=>ProfileScr(),
        '/EditProfile':(context)=>EditProfile(),
        '/MProfileScr':(context)=>MProfileScr(),
        '/MEditProfile':(context)=>MEditProfile(),
        '/MAddProfile':(context)=>MAddProfile(),

//Leader**************************************
        '/DashboardTeamLeader':(context)=>DashboardTeamLeader(),
        '/myTeamL':(context){return TeamL();},
        '/LedTaskScreen':(context)=>LedTaskScreen(),
        '/LAttachementScr':(context)=>LAttachementScr(),
        '/LDetailsTask':(context)=>LDetailsTask(),
        '/AddAttachement':(context)=> AddAttachement(),
        '/leaders_meetings':(context){return  LeadersOmMeetings();},
        //meeting for leader or member
        '/meeting_for_leader':(context){return MeetingForLeaderOm();},
        '/l_subtask':(context){return LeaderSubTask();},
        '/addsubtask':(context){return AddSubtask();},
        '/editsubtask':(context){return EditSubtask();},
        '/myTeamLSelector':(context){return TeamLSelector();},
        '/selectToEditSubtask':(context){return  TeamLSelectorEdit();},
        '/NotificationsScre':(context)=>NotificationsScre(),
        '/myTeamM':(context){return TeamM();},

//did not complete this one yet
        '/comments':(context){return const Comments();},

//Member**************************************
        '/DashboardMember':(context)=>DashboardMember(),
        '/MTaskScr':(context)=>MTaskScr(),
        '/MStatisticsScre':(context)=>MStatisticsScre(),
        '/msubtask':(context){return MemSubTask();},
      },
      theme: ThemeData(
        primarySwatch: pur,
        primaryColor: appFo,
      ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
