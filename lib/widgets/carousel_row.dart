import 'package:dpad_controls/pagination_model.dart';
import 'package:flutter/material.dart';

class CarouselRow<T> extends StatefulWidget {
  final String heading;
  final double cardSpacing;
  final int cardsPerView;
  final Future<Paginated<T>> Function(int page)? handleApiCall;
  final Widget Function(BuildContext, T item, double width, int index, bool? autofocus) cardBuilder;
  final bool autofocusFirst;

  const CarouselRow({
    super.key,
    required this.heading,
    required this.cardSpacing,
    this.cardsPerView =  4,
    this.handleApiCall,
    required this.cardBuilder,
    this.autofocusFirst = false,
  });

  @override
  State<CarouselRow<T>> createState() => _CarouselRowState<T>();
}

class _CarouselRowState<T> extends State<CarouselRow<T>> {
  final ScrollController _scrollController = ScrollController();
  List<T> _items = [];
  int _currentPage = 1;
  bool _isInitialLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    if (widget.handleApiCall != null) {
      _fetchInitialData();
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore &&
        widget.handleApiCall != null) {
      _loadMore();
    }
  }

  Future<void> _fetchInitialData() async {
    if (widget.handleApiCall != null) {
      setState(() => _isInitialLoading = true);
      final result = await widget.handleApiCall!(1);
      setState(() {
        _items = result.data;
        _currentPage = 1;
        _isInitialLoading = false;
        _hasMore = result.count > result.data.length;
      });
    }
  }

  Future<void> _loadMore() async {
    if (widget.handleApiCall == null || !_hasMore || _isLoadingMore) return;

    setState(() => _isLoadingMore = true);

    try {
      final nextPage = _currentPage + 1;
      final result = await widget.handleApiCall!(nextPage);

      if (mounted) {
        if (result.data.isNotEmpty) {
          setState(() {
            _items.addAll(result.data);
            _currentPage = nextPage;
            _hasMore = result.count > _items.length;
          });
        } else {
          setState(() => _hasMore = false);
        }
      }
    } catch (e) {
      debugPrint('Error loading more items: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width / widget.cardsPerView;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        if (_isInitialLoading)
          Center(child: CircularProgressIndicator())
        else
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_items.length, (index) {
                final autofocus = widget.autofocusFirst && index == 0;
                return Padding(
                  padding: EdgeInsets.only(right: widget.cardSpacing),
                  child: SizedBox(
                    width: cardWidth,
                    child: widget.cardBuilder(
                      context, _items[index], cardWidth, index, autofocus),
                  ),
                );
              }),
            ),
          ),
        if (_isLoadingMore)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
} 