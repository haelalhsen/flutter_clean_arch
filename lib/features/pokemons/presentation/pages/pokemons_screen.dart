import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/strings/strings_enum.dart';
import '../../../../core/utils/general_helper.dart';
import '../../../../core/widgets/general_button_widget.dart';
import '../../../../injection_container.dart';
import '../manager/pokemons_cubit.dart';

class PokemonsScreen extends StatefulWidget {
  const PokemonsScreen({super.key});

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
  final _bloc = sl<PokemonsCubit>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        _bloc.listenForMorePokemons();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: GeneralHelper.of(context).onWillPop,
      child: BlocProvider(
        create: (context) => _bloc..listenForPokemons(),
        child: BlocListener<PokemonsCubit, PokemonsState>(
          listener: (context, state) {
            if (state is PokemonsLoadingMoreError) {
              GeneralHelper.of(context).showErrorMessage(state.message);
            }
          },
          child: Scaffold(
            body: BlocBuilder<PokemonsCubit, PokemonsState>(
              builder: (ctx, state) => _bodyWidget(state),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyWidget(state) {
    if (state is PokemonsLoading) {
      return _loadingWidget();
    } else if (state is PokemonsDataLoaded) {
      return _dataListWidget();
    } else if (state is PokemonsLoadingMore) {
      return _dataListLoadingMoreWidget();
    } else if (state is PokemonsEmpty) {
      return _emptyWidget();
    } else if (state is PokemonsError) {
      return _errorWidget(state.message);
    } else {
      return _dataListWidget();
    }
  }

  Widget _loadingWidget() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(Strings.pokemons),
          automaticallyImplyLeading: true,
          pinned: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverToBoxAdapter(
              child: Container(
            height: 80.h,
            child: SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: 20.w,
            ),
          )),
        ),
      ],
    );
  }

  Widget _dataListWidget() {
    return RefreshIndicator(
      onRefresh: _bloc.refreshPage,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            title: Text(Strings.pokemons),
            automaticallyImplyLeading: true,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _pokemonCard(index, context);
                },
                childCount: _bloc.pokemonList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataListLoadingMoreWidget() {
    return RefreshIndicator(
      onRefresh: _bloc.refreshPage,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            title: Text(Strings.pokemons),
            automaticallyImplyLeading: true,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _pokemonItemWidget(index, context);
                },
                childCount: _bloc.pokemonList.length + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pokemonItemWidget(int index, BuildContext context) {
    if (_bloc.pokemonList.length == index) {
      return Container(
        height: 50.0,
        color: Colors.transparent,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return _pokemonCard(index, context);
    }
  }

  Widget _pokemonCard(int index, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 2,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 30.w,
              width: 30.w,
              imageUrl: _bloc.pokemonList.elementAt(index).url,
              placeholder: (context, url) => Image.asset(
                'assets/images/loading.gif',
                fit: BoxFit.fill,
                height: 30.w,
                width: 30.w,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            _bloc.pokemonList.elementAt(index).name,
          ),
        ],
      ),
    );
  }

  Widget _errorWidget(String message) {
    return RefreshIndicator(
      onRefresh: _bloc.refreshPage,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(Strings.pokemons),
            automaticallyImplyLeading: true,
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.w),
            sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 50.sp,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      message,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GeneralButton(
                      width: 40.w,
                      height: 12.w,
                      color: Colors.blue,
                      borderColor: Colors.blue,
                      textColor: Colors.white,
                      text: Strings.tryAgain,
                      onTap: () {
                        _bloc.refreshPage();
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _emptyWidget() {
    return RefreshIndicator(
      onRefresh: _bloc.refreshPage,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(Strings.pokemons),
            automaticallyImplyLeading: true,
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.w),
            sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/img_no_pokemons.png',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'No Pokemons',
                      overflow: TextOverflow.clip,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
