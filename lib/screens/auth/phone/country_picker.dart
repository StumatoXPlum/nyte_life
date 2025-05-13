import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/core/custom_widgets/custom_back_button.dart';
import 'package:nytelife/core/custom_widgets/custom_continue.dart';

class ChooseCountryScreen extends StatefulWidget {
  const ChooseCountryScreen({super.key});

  @override
  ChooseCountryScreenState createState() => ChooseCountryScreenState();
}

class ChooseCountryScreenState extends State<ChooseCountryScreen> {
  List<Country> allCountries = [];
  List<Country> filteredCountries = [];
  String searchQuery = '';
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  void _loadCountries() {
    allCountries = CountryService().getAll();
    setState(() {
      filteredCountries = List.from(allCountries);
    });
  }

  void _filterCountries(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredCountries = List.from(allCountries);
      } else {
        filteredCountries =
            allCountries.where((country) {
              return country.name.toLowerCase().contains(query.toLowerCase());
            }).toList();

        filteredCountries.sort((a, b) {
          if (a.name.toLowerCase().startsWith(query.toLowerCase())) return -1;
          if (b.name.toLowerCase().startsWith(query.toLowerCase())) return 1;
          return 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double iconSize = size.width * 0.05;
    double fontSize = size.width * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(onTap: () => Navigator.pop(context)),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  "Choose Country",
                  style: TextStyle(
                    fontSize: fontSize * 1.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  "Please provide the country code for you phone number.",
                  style: TextStyle(
                    fontSize: fontSize * 0.9,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextField(
                  onChanged: _filterCountries,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: const Icon(Icons.search, color: Colors.black54),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                final isSelected = country == selectedCountry;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: padding * 0.3),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () {
                        setState(() {
                          selectedCountry = country;
                        });
                      },
                      leading: Text(
                        country.flagEmoji,
                        style: TextStyle(fontSize: fontSize * 1.5),
                      ),
                      title: Text(
                        "${country.name} (+${country.phoneCode})",
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: fontSize,
                        ),
                      ),
                      trailing:
                          isSelected
                              ? Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: iconSize,
                              )
                              : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(padding * 1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomContinue(
              onTap: () {
                if (selectedCountry != null) {
                  Navigator.pop(context, selectedCountry);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
