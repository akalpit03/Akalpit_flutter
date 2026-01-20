import 'package:akalpit/features/posts/story/ui/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/posts/story/redux/story_actions.dart';
import 'package:akalpit/features/posts/story/redux/story_model.dart';
import 'package:akalpit/features/posts/story/redux/story_viewmodel.dart';
import 'package:akalpit/features/posts/story/ui/supporter/chatting/chat_type_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/chatting/models/chat_block_model.dart';
import 'package:akalpit/features/posts/story/ui/supporter/mcqs/mcq_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/mcqs/models/mcq_block_model_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/poetry/models/poetry_block_model_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/poetry/poetry_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/sidenotes/models/sidenotes_model_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/sidenotes/sidenotes_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/table/models/table_block_model_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/table/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ===== EXISTING BLOCK WIDGETS =====
import 'package:akalpit/features/posts/story/ui/supporter/heading/heading_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/heading/models/heading_style_model_widget.dart';

import 'package:akalpit/features/posts/story/ui/supporter/paragraph/paragraph_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/paragraph/models/paragraph_model_widget.dart';

import 'package:akalpit/features/posts/story/ui/supporter/image/image_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/image/models/image_model_widget.dart';

import 'package:akalpit/features/posts/story/ui/supporter/list/list_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/list/models/list_block_model_widget.dart';

import 'package:akalpit/features/posts/story/ui/supporter/quote/quote_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/quote/models/quote_model_widget.dart';

import 'package:akalpit/features/posts/story/ui/supporter/divider/divider_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/divider/models/divider_block_model.dart';

import 'package:akalpit/features/posts/story/ui/supporter/timeliner/timeliner_widget.dart';
import 'package:akalpit/features/posts/story/ui/supporter/timeliner/models/timeline_event_model_widget.dart';

 
 
 import 'story_skeleton.dart';

class StoryScreen extends StatefulWidget {
  final String topicId;

  const StoryScreen({
    super.key,
    required this.topicId,
  });

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  bool _minSkeletonTimePassed = false;

  @override
  void initState() {
    super.initState();

    /// Minimum skeleton visibility (1 second)
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _minSkeletonTimePassed = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StoryViewModel>(
      onInit: (store) {
        store.dispatch(FetchStoryByIdAction(widget.topicId));
      },
      converter: (store) => StoryViewModel.fromStore(store),
      builder: (context, vm) {
        /// 🔹 SKELETON LOGIC
        if (!_minSkeletonTimePassed || vm.isLoading) {
          return const StorySkeleton();
        }

        if (vm.error != null) {
          return const _ErrorView();
        }

        if (vm.story == null || vm.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No story found")),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: _StoryView(
            key: const ValueKey('story'),
            story: vm.story!,
          ),
        );
      },
    );
  }
}

class _StoryView extends StatelessWidget {
  final StoryResponseModel story;

  const _StoryView({
    required this.story,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocks = story.blocks ?? [];

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              story.title ?? 'Story',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white60,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 1,
            foregroundColor: Colors.white70,
            floating: true,
            snap: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.separated(
              itemCount: blocks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildBlockWidget(blocks[index]);
              },
            ),
          ),
        ],
      ),

      /// ================= Bottom Bar =================
      bottomNavigationBar: const StoryBottomBar(),
    );
  }

  Widget _buildBlockWidget(dynamic rawBlock) {
    final Map<String, dynamic> block = rawBlock;

    switch (block['type']) {
      case 'heading':
        return HeadingBlockWidget(
          model: HeadingBlockModel.fromMap(block),
        );
      case 'paragraph':
        return ParagraphBlockWidget(
          model: ParagraphBlockModel.fromMap(block),
        );
      case 'image':
        return ImageBlockWidget(
          model: ImageBlockModel.fromMap(block),
        );
      case 'list':
        return ListBlockWidget(
          model: ListBlockModel.fromMap(block),
        );
      case 'mcq':
        return MCQBlockWidget(
          model: MCQBlockModel.fromMap(block),
        );
      case 'chat':
        return ChatBlockWidget(
          model: ChatBlockModel.fromMap(block),
        );
      case 'quote':
        return QuoteBlockWidget(
          model: QuoteBlockModel.fromMap(block),
        );
      case 'poetry':
        return PoetryBlockWidget(
          model: PoetryBlockModel.fromMap(block),
        );
      case 'timeline':
        return TimelineBlockWidget(
          model: TimelineBlockModel.fromMap(block),
        );
      case 'divider':
        return DividerBlockWidget(
          model: DividerBlockModel.fromMap(block),
        );
      case 'sidenote':
        return SidenoteBlockWidget(
          model: SidenoteBlockModel.fromMap(block),
        );
      case 'table':
        return TableBlockWidget(
          model: TableBlockModel.fromMap(block),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 52,
              ),
              const SizedBox(height: 16),
              Text(
                "Oops! Something went wrong\nData not found.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
