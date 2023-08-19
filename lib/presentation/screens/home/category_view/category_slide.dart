import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/loader.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/uimodels/categories_model.dart';
import 'package:salesapp/services/controllers/category_controller.dart';
import 'package:salesapp/services/controllers/product_controller.dart';

import '../../../../model/category_model.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryProvider cat = context.watch<CategoryProvider>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: [
          const CategoryView(
            isFirst: true,
            name: "All products",
          ),
          const CategoryView(
            isFirst: true,
            name: "Services",
          ),
          cat.categoryModel.data == null
              ? const SizedBox.shrink()
              : Row(
                  children: [
                    ...cat.categoryModel.data!.data!.map((e) => CategoryView(
                          isFirst: false,
                          model: e,
                          name: e.name,
                        ))
                  ],
                )
        ],
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  final CategoryDatum? model;
  final bool isFirst;
  final String? name;
  const CategoryView(
      {super.key, this.model, required this.isFirst, required this.name});

  @override
  Widget build(BuildContext context) {
    ProductProvider action =
        Provider.of<ProductProvider>(context, listen: false);

    ProductProvider stream = context.watch<ProductProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () async {
          if (name == "Services") {
            return;
          }

          action.searchProd(name!, true);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: name == stream.filter ? HexColor("#1D2939") : null,
              border: Border.all(
                  color: name == stream.filter
                      ? HexColor("#1D2939")
                      : HexColor("#E0E6F4")),
              borderRadius: BorderRadius.circular(100)),
          child: Row(
            children: [
              name == "All products" || name == "Services"
                  ? const SizedBox.shrink()
                  : Container(
                      height: 20,
                      width: 10,
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#DFE5F3")),
                        borderRadius: BorderRadius.circular(9.5),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: model!.photo ?? "",
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const Center(child: Loader()),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          size: 10,
                        ),
                      ),
                    ),
              const SizedBox(
                width: 5,
              ),
              AppText(
                text: name!,
                color:
                    name == stream.filter ? Colors.white : HexColor("#667085"),
                size: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryViewService extends StatelessWidget {
  const CategoryViewService({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            color: null,
            border: Border.all(color: HexColor("#E0E6F4")),
            borderRadius: BorderRadius.circular(100)),
        child: Row(
          children: [
            Icon(
              Icons.mobile_friendly,
              size: 15,
              color: HexColor("#667085"),
            ),
            AppText(
              text: "Services",
              color: HexColor("#667085"),
              size: 14,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
