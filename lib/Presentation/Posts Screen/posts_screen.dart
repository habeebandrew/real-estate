import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Posts%20Screen/posts%20widgets/post_widgets.dart';
import 'package:pro_2/Util/constants.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,

      body: ListView(
        children: [
          PostCard(
            budget: '2 مليون ل.س',
            description: 'شقة او مكتب يصلح للسكن ولو غرفة ومنتفعات',
            timeAgo: 'منذ 14 ساعة',
          ),
          PostCard(
            budget: '300 مليون ل.س',
            description: 'مطلوب شقة سوبر ديلوكس مفروشة للإيجار منطقة ابو رمانة او المالكي او روضة مع كهرباء 24 ساعة',

            timeAgo: 'منذ يوم',
          ),
          PostCard(
            budget: '300 مليون ل.س',
            description: 'مطلوب شقة سوبر ديلوكس مفروشة للإيجار منطقة ابو رمانة او المالكي او روضة مع كهرباء 24 ساعة',

            timeAgo: 'منذ يوم',
          ),
          PostCard(
            budget: '300 مليون ل.س',
            description: 'مطلوب شقة سوبر ديلوكس مفروشة للإيجار منطقة ابو رمانة او المالكي او روضة مع كهرباء 24 ساعة',

            timeAgo: 'منذ يوم',
          ),
          PostCard(
            budget: '300 مليون ل.س',
            description: 'مطلوب شقة سوبر ديلوكس مفروشة للإيجار منطقة ابو رمانة او المالكي او روضة مع كهرباء 24 ساعة',

            timeAgo: 'منذ يوم',
          ),
          PostCard(
            budget: '300 مليون ل.س',
            description: 'مطلوب شقة سوبر ديلوكس مفروشة للإيجار منطقة ابو رمانة او المالكي او روضة مع كهرباء 24 ساعة',

            timeAgo: 'منذ يوم',
          ),
          PostCard(
            budget: '300 مليون ل.س',
            description: 'مطلوب شقة سوبر ديلوكس مفروشة للإيجار منطقة ابو رمانة او المالكي او روضة مع كهرباء 24 ساعة',

            timeAgo: 'منذ يوم',
          ),
          PostCard(
            budget: '300 مليون ل.س',
            description: 'مطلوب شقة سوبر ديلوكس مفروشة للإيجار منطقة ابو رمانة او المالكي او روضة مع كهرباء 24 ساعة',

            timeAgo: 'منذ يوم',
          ),
          PostCard(
            budget: '300 مليون ل.س',
            description: 'مطلوب شقة سوبر ديلوكس مفروشة للإيجار منطقة ابو رمانة او المالكي او روضة مع كهرباء 24 ساعة',

            timeAgo: 'منذ يوم',
          ),

        ],
      ),
    );
  }
}
