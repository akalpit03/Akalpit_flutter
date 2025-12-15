import 'package:akalpit/features/posts/story/ui/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:akalpit/core/constants/app_colors.dart';

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

 

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StoryView();
  }
}

class _StoryView extends StatelessWidget {
  const _StoryView({super.key});

  final String _storyTitle = 'The Journey of Akalpit';

  /// 🔹 Dummy Story Blocks
  List<Map<String, dynamic>> get blocks =>[
    {
          "type": "image",
          "url":
              "https://dummyimage.com/600x400/cccccc/000000&text=Akalpit+Story",
          "caption": "Akalpit Platform Overview",
        },
        {
          "type": "heading",
          "order": 1,
          "content": {"text": "The Whisper in the Attic", "level": 1},
          "style": {"bold": true, "italic": false, "underline": false},
          "color": "#222222",
          "align": "center"
        },
        {
          "type": "paragraph",
          "order": 2,
          "content": [
            {
              "type": "text",
              "text":
                  "Aarav had known the house all his life: the sag of the roof after monsoon rains, the way the stairs complained under a heavy foot, and the lingering smell of sandalwood that clung to the corners like a memory. When he inherited the place from his grandmother he expected more of the same — boxes of old letters, moth-eaten quilts, and the faint echo of family laughter. He did not expect a whisper to call him up to the attic one stormy night."
            },
            {
              "type": "text",
              "text":
                  "The voice was like paper turning in a quiet library — patient and deliberate. It said only two words, spoken as if from a mouth behind a veil: 'Find library.' Aarav laughed softly to himself, telling himself it was the wind and a trick of loneliness. Still, curiosity tugged at him stronger than fear. He climbed the stairs with a lantern and found a trapdoor he had never noticed. Inside, behind trunks and old trunks of linens, a carved wooden panel hummed faintly with a light that seemed to be breathing."
            },
            {
              "type": "highlight",
              "text":
                  "When he touched the panel the attic dissolved into light.",
              "color": "yellow"
            }
          ]
        },
        {
          "type": "image",
          "order": 3,
          "url": "https://dummyimage.com/600x400/cccccc/000000&text=Akalpit+Story",
          "caption":
              "The shimmering archway at the entrance of the Lost Library of Aetherva",
          "alt": "Shimmering stone arch with runes",
          "width": 400,
          "height": 700,
          "align": "center"
        },
        {
          "type": "heading",
          "order": 4,
          "content": {"text": "The Grand Entrance Hall", "level": 2},
          "style": {"bold": true, "italic": false, "underline": false},
          "color": "#2b3a67",
          "align": "left"
        },
        {
          "type": "paragraph",
          "order": 5,
          "content": [
            {
              "type": "text",
              "text":
                  "Aarav stepped into a vast hall that spread in every direction, columns of carved stone reaching like ribbed spines into a ceiling he could not see. Books floated on slow currents of air, their pages fluttering, and lanterns made of inklight drifted like slow fireflies. A woman in a robe the color of old vellum stood near a pedestal. Her hair, long and silver, seemed woven of writing quill fragments and moonlight. She introduced herself as Lyria, Keeper of the Library, and spoke as someone who had counted the fall of civilizations in footnotes."
            }
          ]
        },
        {
          "type": "list",
          "order": 6,
          "ordered": false,
          "items": [
            {
              "text":
                  "Aisles that rewrite themselves according to a reader's memory",
              "style": {"bold": true}
            },
            {
              "text": "Books that murmur secrets when opened",
              "style": {"italic": true}
            },
            {
              "text":
                  "Guardians who appear as ink-stitched figures in times of peril"
            }
          ]
        },
        {
          "type": "quote",
          "order": 7,
          "text": "Knowledge chooses its seeker, not the other way around.",
          "author": "Lyria, Keeper of Aetherva",
          "style": {
            "italic": true,
            "color": "#555555",
            "bold": false,
            "underline": false
          }
        },
        {
          "type": "heading",
          "order": 8,
          "content": {"text": "The Chronicle of Loss", "level": 2},
          "style": {"bold": true, "italic": false, "underline": false},
          "color": "#333333",
          "align": "left"
        },
        {
          "type": "paragraph",
          "order": 9,
          "content": [
            {
              "type": "text",
              "text":
                  "Lyria explained that Aetherva had been the center of a network of memory and story - a living library that encoded histories, medicines, laws, and songs into volumes that sang when read aloud. Centuries ago, a phenomenon called the Erasure had begun: a black void that devoured knowledge, erasing pages and then memories themselves. The Keepers and scribes bound the most precious keys into artifacts designed to hold memory and to restore what the Erasure stole. Over generations the keys went missing, their names reduced to footnotes, and Aetherva faded from the maps until it existed only in legends."
            },
            {
              "type": "text",
              "text":
                  "Now, murmurs from the boundary suggested that the Erasure was stirring again — a slow hunger at first, licking the edges of texts, then swallowing whole shelves. Lyria believed the Key of Echoes, which could recall what the void had eaten, remained somewhere in the Fragmented Wing, where unfinished stories and lost drafts congealed into shards and whispered like half-memories."
            }
          ]
        },
        {
          "type": "timeline",
          "order": 10,
          "events": [
            {
              "title": "Era of Enlightenment",
              "description":
                  "Aetherva becomes the hub of written magic and knowledge exchange.",
              "date": "1023-01-01T00:00:00.000Z",
              "image": "https://dummyimage.com/600x400/cccccc/000000&text=Akalpit+Story"
            },
            {
              "title": "Rise of the Ink Mages",
              "description":
                  "Writers discover spells woven from sentences; knowledge becomes weaponized.",
              "date": "1100-01-01T00:00:00.000Z"
            },
            {
              "title": "The First Erasure",
              "description":
                  "Books begin to lose pages; memories fade around the edges.",
              "date": "1180-01-01T00:00:00.000Z"
            },
            {
              "title": "The Great Binding",
              "description":
                  "Keepers hid keys and sealed off wings to preserve fragments of knowledge.",
              "date": "1250-01-01T00:00:00.000Z"
            }
          ]
        },
        {
          "type": "divider",
          "order": 11,
          "style": "dashed",
          "thickness": 2,
          "color": "#aaaaaa",
          "marginTop": 8,
          "marginBottom": 8
        },
        {
          "type": "heading",
          "order": 12,
          "content": {"text": "The Fragmented Wing", "level": 3},
          "style": {"bold": true, "italic": false, "underline": false},
          "color": "#2f4f4f",
          "align": "left"
        },
        {
          "type": "poetry",
          "order": 13,
          "lines": [
            {
              "segments": [
                {
                  "text": "Shards of pages drift like birds,",
                  "style": {"italic": true}
                }
              ]
            },
            {
              "segments": [
                {
                  "text": "half-metaphors and broken words.",
                  "style": {"bold": false}
                }
              ]
            }
          ]
        },
        {
          "type": "paragraph",
          "order": 14,
          "content": [
            {
              "type": "text",
              "text":
                  "The Fragmented Wing was a place where narratives had unstitched themselves. Scenes hung mid-air, characters wandered without endings, and sentences dangled like laundry on a line cut in the middle. Aarav stepped across floating islands of story, each island a fragment of a life that had once been whole. He felt an ache in his chest as if the universe itself had misplaced something dear."
            }
          ]
        },
        {
          "type": "chat",
          "order": 15,
          "messages": [
            {
              "sender": "Aarav",
              "text": "Is there any hope of putting these back together?",
              "timestamp": "2025-12-06T12:30:00.000Z"
            },
            {
              "sender": "Lyria",
              "text":
                  "Stories mend when someone remembers them correctly. Memory is the needle, and intention is the thread.",
              "timestamp": "2025-12-06T12:30:30.000Z"
            }
          ]
        },
        {
          "type": "paragraph",
          "order": 16,
          "content": [
            {
              "type": "text",
              "text":
                  "Guided by Lyria's soft clarity, Aarav found the shard that hummed the way the Key of Echoes was described in the pedestals' footnotes — a shard glowing with the echo of a voice that had once told a story. But a Guardian of Blank Pages blocked his path: a colossus whose limbs were folded pages and whose voice swallowed vowels."
            }
          ]
        },
        {
          "type": "mcq",
          "order": 17,
          "question":
              "What should Aarav do to pacify the Guardian of Blank Pages?",
          "options": [
            {"text": "Fight the Guardian with force"},
            {"text": "Rewrite a broken sentence with intention"},
            {"text": "Run away and leave the library"},
            {"text": "Offer the Guardian a book of blank pages"}
          ],
          "correctOption": 1,
          "explanation":
              "The Guardian responds to creation and the act of giving narrative form — rewriting restores what is missing."
        },
        {
          "type": "paragraph",
          "order": 18,
          "content": [
            {
              "type": "text",
              "text":
                  "Aarav chose the second option: he opened the broken book the Guardian had been guarding and found a sentence fractured in the middle. With Lyria's guidance he whispered his intention and rearranged words until the sentence sang together. In that moment the Guardian's blank pages filled with letters; its terrible hunger eased and it bowed, a creature choosing to remember again."
            }
          ]
        },
        {
          "type": "image",
          "order": 19,
          "url": "https://dummyimage.com/600x400/cccccc/000000&text=Akalpit+Story",
          "caption": "The Key of Echoes recovered from the Fragmented Wing",
          "alt": "A small silver key shaped like an ear",
          "width": 400,
          "height": 500,
          "align": "center"
        },
        {
          "type": "heading",
          "order": 20,
          "content": {"text": "Restoring What Was Lost", "level": 2},
          "style": {"bold": true, "italic": false, "underline": false},
          "color": "#1a3b3b",
          "align": "left"
        },
        {
          "type": "paragraph",
          "order": 21,
          "content": [
            {
              "type": "text",
              "text":
                  "With the Key of Echoes in hand, Aarav and Lyria traversed endless stacks, placing the key in the center of rooms where the Erasure had gnawed deepest. The key resonated: a chime of recollection pulsed outward. Pages regained paragraphs, and characters remembered their names. Here and there, however, the Erasure's teeth had chewed too far. Some memories could be coaxed back only in part; others remained shrouded in fog."
            },
            {
              "type": "text",
              "text":
                  "Aarav learned the bitter lesson that saving knowledge was not the same as restoring the past exactly as it had been. Restoration required compassion and the willingness to accept a new story that honored the old while making space for what could be found again."
            }
          ]
        },
        
        {
          "type": "sidenote",
          "order": 23,
          "text":
              "Lyria hinted that the Key of Script required a writer's true intent to awaken; mere strength of hand would not suffice.",
          "position": "right",
          "highlight": "#ffef99"
        },
        {
          "type": "paragraph",
          "order": 24,
          "content": [
            {
              "type": "text",
              "text":
                  "Night had no meaning in Aetherva; instead, the library's own pulse dictated a rhythm of quiet and discovery. Eventually, the library grew still, not from exhaustion but from a soft settling of resolved narratives. Lyria offered Aarav a small, leathery notebook that glowed like moonlight on old vellum."
            },
            {
              "type": "text",
              "text":
                  "This, she told him, was the Seeker's Codex. It would record the truth of his journey in a way that could be shared and remembered by others."
            }
          ]
        }
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: CustomScrollView(
        slivers: [
          /// ================= AppBar =================
          SliverAppBar(
            title: Text(
              _storyTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.scaffoldBackground,
            floating: true,
            snap: true,
          ),

          /// ================= Story Content =================
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

  Widget _buildBlockWidget(Map<String, dynamic> block) {
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

      case 'quote':
        return QuoteBlockWidget(
          model: QuoteBlockModel.fromMap(block),
        );

      case 'timeline':
        return TimelineBlockWidget(
          model: TimelineBlockModel.fromMap(block),
        );

      case 'divider':
        return DividerBlockWidget(
          model: DividerBlockModel.fromMap(block),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
