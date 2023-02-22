import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/dashboard_viewmodel.dart';

class MyPostedItem extends StatelessWidget {
  const MyPostedItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: Provider.of<DashboardViewModel>(context).productByLoginUser.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
              child: Card(
                child: Container(
                  height: 200,
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
                                      image: NetworkImage(Provider.of<DashboardViewModel>(context).productByLoginUser[index].imageUrl),
                                      fit: BoxFit.cover

                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children:  [
                                  Expanded(child: Text(Provider.of<DashboardViewModel>(context).productByLoginUser[index].name,style: const TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(child: Text("\$ ${Provider.of<DashboardViewModel>(context).productByLoginUser[index].price}",style: const TextStyle(overflow: TextOverflow.ellipsis),)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
