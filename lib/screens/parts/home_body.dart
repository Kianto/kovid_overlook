import 'package:flutter/material.dart';
import 'package:kovidoverlook/models/country.dart';
import 'package:kovidoverlook/widgets/country_card.dart';
import 'package:shimmer/shimmer.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.countries});

  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    if (countries.isEmpty) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          padding: const EdgeInsets.only(top: 36),
          child: _buildShimmerList(),
        ),
        enabled: true,
        direction: ShimmerDirection.rtl,
      );
    }

    return Container(
      padding: const EdgeInsets.only(
        top: 36,
        bottom: 12.0,
      ),
      child: ListView.separated(
        separatorBuilder: (context, _) => const Divider(
          color: Colors.white,
        ),
        itemCount: countries.length,
        itemBuilder: (context, index) => CountryCard(
          country: countries[index],
          onTap: (country) {},
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Colors.orangeAccent,
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemBuilder: (_, __) => ListTile(
        leading: Container(
          width: 48.0,
          height: 48.0,
          color: Colors.white,
        ),
        trailing: Container(
          width: 48.0,
          height: 48.0,
          color: Colors.white,
        ),
        title: Container(
          width: double.infinity,
          height: 8.0,
          color: Colors.white,
        ),
        subtitle: Container(
          width: 40.0,
          height: 8.0,
          color: Colors.white,
        ),
      ),
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
