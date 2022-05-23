import 'package:flutter/material.dart';
import 'package:tracker/shared/constants.dart';
TextEditingController searchController=TextEditingController();
/// *****************************************************************************/
/*Widget defaultBottun({double width=double.infinity,
  Color c=const Color.fromARGB(255, 121, 120, 117),
  bool isUpperCase=true,
  double radius=5,
  required void Function() function,
  required String text
}) =>
    Container(width: width,
      height:40,
//color: c,
      child: MaterialButton(onPressed:function,
        child:  Text(text,style:const TextStyle(color: Colors.white,fontSize: 17)),
      ),
      decoration: BoxDecoration(color:c,borderRadius: BorderRadius.circular(radius)),
    );
*/
/// *****************************************************************************/

Widget defaultTextFormField({
  bool ispass=false,
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
//required Function() onChanged,
  required String? Function(String?)? validate,
//required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  // ignore: non_constant_identifier_names
  void suffixfunc,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: ispass,
  onFieldSubmitted: onSubmit,
  // onChanged: onChanged,
  validator: validate,
  decoration: InputDecoration(
    labelText: label ,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(onPressed: (){},//suffixfunc,
      icon: Icon(suffix),) : null,
    border:const OutlineInputBorder(),
  ),
);
/// *****************************************************************************/
   Widget getTextWidgets(List<String> strings)
   {
     return Column(children: strings.map((item) => Text(item,style: const TextStyle(fontSize: 18),)).toList());
   }
/// *****************************************************************************/
Table meetingsTable()=>Table(

  /* border: TableBorder.symmetric(
                              inside: const BorderSide(width: 1,),
                            ),*/
  // border: TableBorder.all(),
  columnWidths: const {
    0: FractionColumnWidth(0.2),
    1: FractionColumnWidth(0.15),
    2: FractionColumnWidth(0.15),
    3: FractionColumnWidth(0.3),
    4: FractionColumnWidth(0.3),
  },
  children: [

    buildRow(const ['Date','Status','Starts','with'],isHeader: true),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
    buildRow(const ['12/3/2020','done','6:30','all lovely people']),
  ],
);
TableRow buildRow(final List<String> cells,{bool isHeader=false}) => TableRow(
    children:[
      //...
      //If you want to use the .map function inside ListView children,
      // you should convert map result - iterable - to list and use the spread operator to spread this list inside children
      ...cells.map((cell){
        return Padding(padding: const EdgeInsets.all(12),
          child: Center(child: Text(cell,style:style(isHeader),overflow: TextOverflow.ellipsis,),),
        );
      })]
);
/// *****************************************************************************/