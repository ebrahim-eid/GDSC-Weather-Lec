import 'package:flutter/material.dart';
import 'package:weather_app/screens/Home_page.dart';
import 'package:weather_app/server/api_helper.dart';
class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text(
            'ENTER CITY',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                      hintText: 'Enter city name',
                      labelText: 'Search',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' Search must not be empty ';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: MaterialButton(
                    onPressed: () async{
                      if(formKey.currentState!.validate()){
                        await ApiHelper().getData(searchController.text).then((value) {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(weatherModel: value,)));
                        });
                      }
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





//      base url=http://api.weatherapi.com/
//      v1/forecast.json?key=f92417adebf74911ae6223847231204&q=cairo