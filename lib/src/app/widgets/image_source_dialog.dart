import 'package:flutter/material.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/domain/types/enums/image_source_type.dart';

class ImageSourceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: size.width - 50,
        height: size.width - 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              PhoneBookTexts.chooseImageSource,
              style: kContentStyleBold(kBlack),
            ),
            SizedBox(height: horizantalPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pop(ImageSourceType.GALLERY),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(2)),
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.image,
                      size: 36,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(width: defaultSizedBoxPadding),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pop(ImageSourceType.CAMERA),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(2)),
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.camera_alt,
                      size: 36,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
