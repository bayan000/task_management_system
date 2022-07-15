class  ModelTasks {
  String nameTask;
  String discription;

  List<String> imgMember;
  String date;
  int percent;

  ModelTasks({
    required this.nameTask,
    required this.discription,
    required this.date,
    required this.percent,
    required this.imgMember,
  });
}

class dataTasks {
  static List<ModelTasks> dataT = [
    ModelTasks(
      nameTask: 'HR Manager\'s Day',
      discription: 'this is discription about task',
      date: '20 Sep 2020',
      percent: 30,
      imgMember: [
        'https://www.pngkit.com/png/detail/115-1150342_user-avatar-icon-iconos-de-mujeres-a-color.png',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQARPRzahfEwt6xf7y7V2wDIWSKRGb0PmE3ow&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNQb4jJzXX5S9IgIQW_hUtTfl4e_CFiu9toQ&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQjADRuE-0UnDCMQKY7ITO2-wKa36wT0H0mj61op83icDkxQ9beFWW7Pf5weon8WM696E&usqp=CAU',


      ],),
    ModelTasks(
      nameTask: 'Study Case',
      discription: 'this is discription about task',
      date: '24 Sep 2020',
      percent: 40,
      imgMember: [
        'https://www.pngkit.com/png/detail/115-1150342_user-avatar-icon-iconos-de-mujeres-a-color.png',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQARPRzahfEwt6xf7y7V2wDIWSKRGb0PmE3ow&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNQb4jJzXX5S9IgIQW_hUtTfl4e_CFiu9toQ&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQjADRuE-0UnDCMQKY7ITO2-wKa36wT0H0mj61op83icDkxQ9beFWW7Pf5weon8WM696E&usqp=CAU',

      ],


    ),
    ModelTasks(
      nameTask: 'Post For Facebook',
      discription: 'this is discription about task',
      date: '28 Sep 2020',
      percent: 50,
      imgMember: [
        'https://www.pngkit.com/png/detail/115-1150342_user-avatar-icon-iconos-de-mujeres-a-color.png',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQARPRzahfEwt6xf7y7V2wDIWSKRGb0PmE3ow&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNQb4jJzXX5S9IgIQW_hUtTfl4e_CFiu9toQ&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQjADRuE-0UnDCMQKY7ITO2-wKa36wT0H0mj61op83icDkxQ9beFWW7Pf5weon8WM696E&usqp=CAU',


      ],


    ),
    ModelTasks(
      nameTask: 'Pre Setuation Employees',
      discription: 'this is discription about task',
      date: '28 Sep 2020',
      percent: 60,
      imgMember: [

        'https://www.pngkit.com/png/detail/115-1150342_user-avatar-icon-iconos-de-mujeres-a-color.png',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQARPRzahfEwt6xf7y7V2wDIWSKRGb0PmE3ow&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNQb4jJzXX5S9IgIQW_hUtTfl4e_CFiu9toQ&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQjADRuE-0UnDCMQKY7ITO2-wKa36wT0H0mj61op83icDkxQ9beFWW7Pf5weon8WM696E&usqp=CAU',


      ],


    ),
    ModelTasks(
      nameTask: 'Send a brif to the client ',
      discription: 'this is discription about task',
      date: '1 Oct 2020',
      percent: 80,
      imgMember: [

        'https://www.pngkit.com/png/detail/115-1150342_user-avatar-icon-iconos-de-mujeres-a-color.png',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQARPRzahfEwt6xf7y7V2wDIWSKRGb0PmE3ow&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNQb4jJzXX5S9IgIQW_hUtTfl4e_CFiu9toQ&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQjADRuE-0UnDCMQKY7ITO2-wKa36wT0H0mj61op83icDkxQ9beFWW7Pf5weon8WM696E&usqp=CAU',



      ],


    )



  ];
}