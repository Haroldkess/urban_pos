import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../../generalwidgets/SearchBox.dart';
import '../../generalwidgets/gen_page.dart';
import '../../generalwidgets/text.dart';
import 'draft_listing.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GenPage(
      title: "Draft",
      showMenu: false,
      hasDash: false,
      hint: 'Search draft',
      showFloat: false,
      showFooter: true,
      body: Container(color: HexColor("#F9FAFB"), child: const DraftListings()),
    );
  }
}
