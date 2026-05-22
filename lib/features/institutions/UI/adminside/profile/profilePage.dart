import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final _dummyProfile = {
  'id': 'inst_01',
  'name': 'CSJMU University',
  'username': 'csjmu_official',
  'city': 'Kanpur, Uttar Pradesh',
  'about': 'Chhatrapati Shahu Ji Maharaj University is a leading public university committed to academic excellence, research, and holistic student development. Affiliated with 350+ colleges across UP.',
  'logo': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
  'coverImage': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
  'isFollowing': false,
  'stats': {
    'followers': 4800,
    'services': 34,
    'bookings': 210,
    'rating': 4.6,
  },
};

class InstitutionProfilePage extends StatefulWidget {
  final bool isOwnProfile;
  const InstitutionProfilePage({super.key, this.isOwnProfile = true});

  @override
  State<InstitutionProfilePage> createState() => _InstitutionProfilePageState();
}

class _InstitutionProfilePageState extends State<InstitutionProfilePage> {
  final profile = _dummyProfile;
  late bool _isFollowing;

  @override
  void initState() {
    super.initState();
    _isFollowing = profile['isFollowing'] as bool;
  }

  void _toggleFollow() {
    setState(() => _isFollowing = !_isFollowing);
    // TODO: follow API
  }

  String _fmt(int count) =>
      count >= 1000 ? '${(count / 1000).toStringAsFixed(1)}k' : '$count';

  @override
  Widget build(BuildContext context) {
    final stats = Map<String, dynamic>.from(profile['stats'] as Map);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // Cover
          SliverAppBar(
            expandedHeight: 210,
            pinned: true,
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              if (widget.isOwnProfile)
                IconButton(
                  icon: const Icon(Icons.settings_outlined, color: Colors.white),
                  onPressed: () {},
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: profile['coverImage'] as String,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: const Color(0xFF1A1A1A)),
                    errorWidget: (_, __, ___) => Container(color: const Color(0xFF1A1A1A)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo + buttons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -28),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black, width: 3),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 12)],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: CachedNetworkImage(
                              imageUrl: profile['logo'] as String,
                              height: 86, width: 86, fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Container(
                                height: 86, width: 86,
                                color: const Color(0xFF2A2A2A),
                                child: const Icon(Icons.account_balance, color: Colors.white24, size: 32),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (widget.isOwnProfile)
                        _OutlineButton(label: 'Edit Profile', onTap: () {})
                      else ...[
                        _FollowButton(isFollowing: _isFollowing, onTap: _toggleFollow),
                        const SizedBox(width: 10),
                        _OutlineButton(
                          label: 'Councils',
                          icon: Icons.groups_outlined,
                          onTap: () {}, // TODO: navigate to councils
                        ),
                      ],
                    ],
                  ),

                  // Name
                  Text(profile['name'] as String,
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 4),

                  // Username + City
                  Row(
                    children: [
                      Text('@${profile['username']}',
                          style: const TextStyle(color: Colors.white38, fontSize: 13)),
                      const SizedBox(width: 10),
                      const Icon(Icons.location_on_outlined, color: Colors.white24, size: 13),
                      const SizedBox(width: 3),
                      Text(profile['city'] as String,
                          style: const TextStyle(color: Colors.white38, fontSize: 13)),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // About
                  Text(profile['about'] as String,
                      style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.6)),

                  const SizedBox(height: 20),

                  // Stats
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        _StatItem(value: _fmt(stats['followers'] as int), label: 'Followers'),
                        _StatDivider(),
                        _StatItem(value: '${stats['services']}', label: 'Services'),
                        _StatDivider(),
                        _StatItem(value: '${stats['bookings']}', label: 'Bookings'),
                        _StatDivider(),
                        _StatItem(value: '${stats['rating']}⭐', label: 'Rating'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Councils button
                  GestureDetector(
                    onTap: () {}, // TODO: navigate to councils list
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.groups_outlined, color: Colors.white60, size: 18),
                          SizedBox(width: 8),
                          Text('View All Councils',
                              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 14)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 13),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onTap;
  const _FollowButton({required this.isFollowing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: isFollowing ? Colors.transparent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isFollowing ? Colors.white38 : Colors.white),
        ),
        child: Text(
          isFollowing ? 'Following' : 'Follow',
          style: TextStyle(
            color: isFollowing ? Colors.white60 : Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, color: Colors.white70, size: 14), const SizedBox(width: 5)],
            Text(label, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: Colors.white10);
}