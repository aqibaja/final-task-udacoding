import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/models/ReviewsModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:sizer/sizer.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget(
      {Key key,
      @required this.values,
      @required this.intRating,
      @required this.index})
      : super(key: key);

  final List<ReviewsModel> values;
  final int intRating;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 9),
      child: Column(
        children: [
          SizedBox(
            height: 4.1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 31,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      Urls.USER_IMAGE_URL + values[index].imageUrl),
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(
                width: 1.0.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 3.9),
                    child: Text(
                      values[index].namaLengkap,
                      style: TextStyle(
                          fontSize: 13.0.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: 1.0.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, i) {
                        bool exist = true;
                        exist = true;
                        if (i > 0) {
                          if (intRating <= i) {
                            exist = false;
                          }
                        }

                        return (exist == true)
                            ? iconStar(Icons.star, 3.0.h)
                            : iconStar(Icons.star_outline, 3.0.h);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 1.7.h,
          ),
          Container(
            width: 100.0.w,
            height: 10.0.h,
            child: Text(
              values[index].ulasan,
              style: TextStyle(fontSize: 10.0.sp),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
          SizedBox(
            height: 1.7.h,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 1, 9, 0),
            child: Container(
              height: 1.0,
              width: 100.0.w,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}

//icon untuk rating
Icon iconStar(IconData icon, double size) {
  return Icon(
    icon,
    color: Colors.yellow[600],
    size: size,
  );
}
