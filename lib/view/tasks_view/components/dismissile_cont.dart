import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/style.dart';

class DismissibleCustomContainer extends StatefulWidget {
  final List<ListOfTilesModel> tilesList;
  final int index;
  const DismissibleCustomContainer({Key key, this.tilesList, this.index})
      : super(key: key);

  @override
  _DismissibleCustomContainerState createState() =>
      _DismissibleCustomContainerState();
}

class _DismissibleCustomContainerState
    extends State<DismissibleCustomContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  build(_) {
    final textTheme = Theme.of(_).textTheme;
    return Container(
      decoration: _buildBoxDecoration(),
      margin: EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
      child: _buildListTile(textTheme),
    );
  }

  Widget _buildListTile(TextTheme textTheme) {
    final latitude = widget.tilesList[widget.index].latitude;
    final longitude = widget.tilesList[widget.index].longitude;
    final List<String> times =
        widget.tilesList[widget.index].dateInString.split(RegExp("-"));
    return FutureBuilder<List<Address>>(
        future: Geocoder.local
            .findAddressesFromCoordinates(Coordinates(latitude, longitude)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              final address = snapshot.data.first;
              return ListTile(
                title: Text(widget.tilesList[widget.index].title,
                    style: Style.textStyle1),
                subtitle: Text(
                    //${address.subLocality}, ${address.locality}
                    "Date: ${times[0]}\n${address.addressLine}",
                    style: Style.textStyle2),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        "${widget.tilesList[widget.index].currency} ${widget.tilesList[widget.index].amount}",
                        style: Style.textStyle1),
                    Text(
                        "Option: ${widget.tilesList[widget.index].option}, Time: ${times[1]}\n${address.adminArea},${address.countryName}",
                        style: Style.textStyle2),
                  ],
                ),
              );
            } else
              return Center(child: Text("Location is empty"));
          } else
            return CircularProgressIndicator();
        });
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      gradient: Style.linearGradient,
      borderRadius: BorderRadius.circular(5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xffa6a6a6),
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
