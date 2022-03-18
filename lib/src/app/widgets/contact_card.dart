import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/contact_detail/contact_detail_view.dart';
import 'package:phone_book/src/domain/entities/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  ContactCard(this.contact);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          width: size.width,
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: contact.imageUrl.isNotEmpty
                        ? Image.network(
                            contact.imageUrl,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            profilePhotoPlaceHolder,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${contact.firstName} ${contact.lastName}',
                          style: kContentStyleBold(kBlack)),
                      Text(
                        contact.phoneNumber,
                        style: kContentStyleThin(kBlack.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: kBlack,
                size: 18,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: size.width,
          height: 75,
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                (_) => kPrimaryColor.withOpacity(0.5),
              ),
            ),
            child: Container(),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ContactDetailView(contact),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
