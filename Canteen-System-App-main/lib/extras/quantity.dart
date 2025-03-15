// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../components/database.dart';
//
// class QuantityContainer extends StatefulWidget{
//   final itemKey, item, price;
//   const QuantityContainer({super.key, this.itemKey, this.item, this.price});
//
//   @override
//   State<QuantityContainer> createState() => _QuantityContainerState();
// }
//
// class _QuantityContainerState extends State<QuantityContainer> {
//   var counter = 1;
//
//   // final controller = Get.put(Controller());
//
//
//   @override
//   Widget build(BuildContext context){
//     return Expanded(
//       child: Container(
//         // color: Colors.green,
//         height: 200,
//         width: 125,
//         // color: Colors.blue,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             IconButton(onPressed: (){
//               setState(() {
//                 counter++;
//                 AddtoTotal(widget.price);
//               });
//             }
//                 , icon: Icon(Icons.add_circle_outline),),
//
//             // Padding(padding: const EdgeInsets.all(5),
//             // child: Text('${counter.toString()}', style: TextStyle(fontSize: 15),),),
//             IconButton(onPressed: (){
//               if (counter > 1){
//                 setState(() {
//                   counter--;
//                   total= total - widget.price;
//                 });
//               }
//             }
//                 , icon: Icon(Icons.remove_circle_outline)),
//
//           ],
//         )
//       ),
//     );
//   }
// }