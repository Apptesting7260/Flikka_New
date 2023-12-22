import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/ViewLanguageModel/VIewLanguageModel.dart';

class LanguageSelector extends StatefulWidget {
     List? selectedLanguageList  ;
     List? selectedLanguageId  ;
     List<LanguageModel>? languageList ;
   LanguageSelector({super.key, this.selectedLanguageList,this.selectedLanguageId , required this.languageList});

  @override
  LanguageSelectorState createState() => LanguageSelectorState();
}

class LanguageSelectorState extends State<LanguageSelector> {

 static List languages = [];
  List? selectedLanguages = [] ;

 @override
  void initState() {
    super.initState();
    widget.selectedLanguageList?.length != 0 && widget.selectedLanguageList != null ?
        selectedLanguages = widget.selectedLanguageList : [] ;
    widget.selectedLanguageId?.length != 0 && widget.selectedLanguageId != null ?
        languages = widget.selectedLanguageId! : [] ;
    print(languages) ;
  }

  @override
  Widget build(BuildContext context) {
    return Column( mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint:  Text( "select language"  ,style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: const Color(0xffCFCFCF)),),
              onChanged: ( language) {

              },
              items: widget.languageList?.map(( language) {
                return DropdownMenuItem(
                  value: language.languages,
                  onTap: () {
                    setState(() {
                      if(languages.contains(language.id.toString())) {
                      }else {
                        languages.add(language.id.toString());
                        selectedLanguages?.add(language.languages) ;
                        widget.selectedLanguageList = languages ;
                        debugPrint(languages.toString());
                      }
                    });
                  },
                  child: Text("${language.languages}",style :Theme.of(context).textTheme.bodyMedium),
                );
              }).toList(),
              buttonStyleData: ButtonStyleData(
                height: Get.height*0.08,
                width: double.infinity,
                padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                  color: const Color(0xff353535),
                ),
                elevation: 2,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25))
              ),
              iconStyleData:  IconStyleData(
                icon: Image.asset('assets/images/arrowdown.png'),
                iconSize: 14,
                iconEnabledColor: Colors.yellow,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),
        SizedBox(height: Get.height*.015,) ,
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:   const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2 ,
              mainAxisExtent: 36,
              crossAxisSpacing: 8 ,
              mainAxisSpacing: 8,
            ),
            itemCount: selectedLanguages?.length,
            itemBuilder: (context , index){
              return Container(
                padding: const EdgeInsets.only(right: 8,left: 18),
                decoration: BoxDecoration(
                  color: const Color(0xff373737),
                    borderRadius: BorderRadius.circular(35),
                ),
                height: Get.height * 0.6,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Flexible(child: Text(selectedLanguages?[index],overflow: TextOverflow.ellipsis,)) ,
                  IconButton(onPressed: (){
                    setState(() {
                      languages.removeAt(index) ;
                      selectedLanguages?.removeAt(index) ;
                      widget.selectedLanguageList = languages ;
                    });

                  }, icon: const Icon(Icons.close))
                ],
                ),
              ) ;
            }) ,
      ],
    );
  }
}
