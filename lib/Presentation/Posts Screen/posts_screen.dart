import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Posts%20Cubit/posts_cubit.dart';
import 'package:pro_2/Bloc/Posts%20Cubit/posts_cubit.dart';
import 'package:pro_2/Presentation/Posts%20Screen/posts%20widgets/post_widgets.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {

      },
      builder: (context, state) {
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
      },
    );
  }
}
