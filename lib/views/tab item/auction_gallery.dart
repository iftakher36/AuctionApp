import 'package:auction_app/viewmodel/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AuctionGallery extends StatelessWidget {
  const AuctionGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: Provider.of<DashboardViewModel>(context).productByAllUser.length,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
          child: Container(
           constraints: BoxConstraints(
             minHeight: 200
           ),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(1,1)
                  ),
                  BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(1,1)
                  ),
                ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(Provider.of<DashboardViewModel>(context).productByAllUser[index].imageUrl),
                                fit: BoxFit.cover

                            )
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:  [
                          Expanded(child: Text(Provider.of<DashboardViewModel>(context).productByAllUser[index].name,style: const TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      ///details will show next page
                      /*Row(
                        children:  [
                          Expanded(child: Text(Provider.of<DashboardViewModel>(context).productByAllUser[index].details,style: const TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)),
                        ],
                      ),*/
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(child: Text("\$ ${Provider.of<DashboardViewModel>(context).productByAllUser[index].price}",style: const TextStyle(overflow: TextOverflow.ellipsis),)),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(child: Text("End Time ${
            DateFormat('dd,MMM E AT hh:mm a').format(
            DateTime.parse(Provider.of<DashboardViewModel>(context).productByAllUser[index].endDate))}",style: const TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)),],
                      ),
                      const SizedBox(height: 5,),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
