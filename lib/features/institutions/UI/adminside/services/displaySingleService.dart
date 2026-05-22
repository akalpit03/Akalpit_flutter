import 'package:akalpit/features/institutions/UI/adminside/services/bookingConfirmation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
 

class ServiceDetailPage extends StatefulWidget {
  final Map<String, dynamic> service;
  final bool isAdmin;

  const ServiceDetailPage({
    super.key,
    required this.service,
    this.isAdmin = false,
  });

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  final Set<int> _selectedIndexes = {};

  List<Map<String, dynamic>> get _amenities =>
      List<Map<String, dynamic>>.from(widget.service['amenities'] as List);

  double get _totalCost => _selectedIndexes.fold(0.0, (sum, i) {
        return sum + (_amenities[i]['price'] as double);
      });

  List<String> get _selectedItems =>
      _selectedIndexes.map((i) => _amenities[i]['name'] as String).toList();

  void _toggleItem(int index) {
    setState(() {
      if (_selectedIndexes.contains(index)) {
        _selectedIndexes.remove(index);
      } else {
        _selectedIndexes.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;
    final amenities = _amenities;
    final hasSelection = _selectedIndexes.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // ── Top Image ──────────────────────────────────────────
          Stack(
            children: [
              SizedBox(
                height: 260,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: service['image'] ?? '',
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: const Color(0xFF1A1A1A)),
                  errorWidget: (_, __, ___) => Container(
                    color: const Color(0xFF1A1A1A),
                    child: const Icon(Icons.image_outlined, color: Colors.white12, size: 48),
                  ),
                ),
              ),
              // Gradient
              Container(
                height: 260,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      Colors.black.withOpacity(0.85),
                    ],
                  ),
                ),
              ),
              // Back button
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 12,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                  ),
                ),
              ),
              // Name + category + rating at bottom of image
              Positioned(
                bottom: 14,
                left: 16,
                right: 16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Text(
                              service['category'] ?? '',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            service['name'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 15),
                          const SizedBox(width: 4),
                          Text(
                            '${service['rating'] ?? '-'}',
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── Amenities List ─────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Amenities & Items',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    if (!widget.isAdmin && _selectedIndexes.isNotEmpty)
                      Text(
                        '${_selectedIndexes.length} selected',
                        style: const TextStyle(color: Colors.white38, fontSize: 13),
                      ),
                  ],
                ),
                if (!widget.isAdmin) ...[
                  const SizedBox(height: 4),
                  const Text(
                    'Tap an item to add it to your basket',
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
                const SizedBox(height: 14),

                ...amenities.asMap().entries.map((entry) {
                  final i = entry.key;
                  final amenity = entry.value;
                  final isSelected = _selectedIndexes.contains(i);

                  return GestureDetector(
                    onTap: widget.isAdmin ? null : () => _toggleItem(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white.withOpacity(0.1) : const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? Colors.white54 : Colors.white.withOpacity(0.07),
                          width: isSelected ? 1.2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          if (!widget.isAdmin) ...[
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: isSelected ? Colors.white : Colors.white38,
                                  width: 1.5,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check, color: Colors.black, size: 14)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: Text(
                              amenity['name'],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white70,
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white54,
                              fontSize: isSelected ? 15 : 14,
                              fontWeight: FontWeight.bold,
                            ),
                            child: Text('₹${(amenity['price'] as double).toStringAsFixed(0)}'),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          // ── Bottom Bar ─────────────────────────────────────────
          if (!widget.isAdmin)
            Container(
              padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 14),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08))),
              ),
              child: Row(
                children: [
                  // Animated cost
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-0.2, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),
                    child: hasSelection
                        ? Column(
                            key: const ValueKey('cost'),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Total', style: TextStyle(color: Colors.white38, fontSize: 11)),
                              Text(
                                '₹${_totalCost.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(key: ValueKey('empty'), width: 0),
                  ),

                  if (hasSelection) const SizedBox(width: 16),

                  Expanded(
                    child: GestureDetector(
                      onTap: hasSelection
                          ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BookingConfirmationPage(
                                    service: widget.service,
                                    selectedItems: _selectedItems,
                                    totalCost: _totalCost,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: hasSelection ? Colors.white : const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                hasSelection ? Icons.shopping_basket_outlined : Icons.touch_app_outlined,
                                color: hasSelection ? Colors.black : Colors.white38,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                hasSelection
                                    ? 'Keep in Basket  (${_selectedIndexes.length})'
                                    : 'Select items to book',
                                style: TextStyle(
                                  color: hasSelection ? Colors.black : Colors.white38,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}