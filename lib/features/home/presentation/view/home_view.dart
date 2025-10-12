import 'package:asset_management/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:asset_management/features/user/presentation/view/login_view.dart';

import '../../../../core/core.dart';
import '../../../../main_export.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    final modules = context
        .read<UserBloc>()
        .state
        .user
        ?.modules
        ?.map((e) => e.toString())
        .toList();

    context.read<HomeCubit>().loadItems(modules!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSET MANAGEMENT'),
        elevation: 0,
        actions: [
          BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state.status == StatusUser.success) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () => context.read<UserBloc>().add(OnLogoutUser()),
                icon: Icon(Icons.logout),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // AppSpace.vertical(12),
            // Container(
            //   height: 300,
            //   width: double.infinity,
            //   color: AppColors.kBase,
            // ),
            AppSpace.vertical(16),
            Expanded(
              child: BlocBuilder<HomeCubit, List<Map<String, dynamic>>>(
                builder: (context, state) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final item = state[index];

                      return Material(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(8),
                        clipBehavior: Clip.antiAlias,
                        elevation: 3,
                        shadowColor: Colors.black.withOpacity(0.7),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => item['view'],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(item['icons'], height: 32),
                                AppSpace.vertical(8),
                                Text(
                                  item['name'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
