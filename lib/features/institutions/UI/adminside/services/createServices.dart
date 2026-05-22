import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// CREATE SERVICE PAGE
// ─────────────────────────────────────────────────────────────

class CreateServicePage extends StatefulWidget {
  const CreateServicePage({super.key});

  @override
  State<CreateServicePage> createState() => _CreateServicePageState();
}

class _CreateServicePageState extends State<CreateServicePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  bool _isLoading = false;

  // Amenities
  final List<Map<String, dynamic>> _amenities = [];
  final _amenityNameController = TextEditingController();
  final _amenityPriceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _amenityNameController.dispose();
    _amenityPriceController.dispose();
    super.dispose();
  }

  void _addAmenity() {
    final name = _amenityNameController.text.trim();
    final priceText = _amenityPriceController.text.trim();
    if (name.isEmpty || priceText.isEmpty) return;
    final price = double.tryParse(priceText);
    if (price == null) return;

    setState(() {
      _amenities.add({'name': name, 'price': price});
      _amenityNameController.clear();
      _amenityPriceController.clear();
    });
  }

  void _removeAmenity(int index) {
    setState(() => _amenities.removeAt(index));
  }

  Future<void> _onPublish() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_amenities.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one amenity or item'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // TODO: API
    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Service created successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Add Service',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: _isLoading ? null : _onPublish,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.black),
                      )
                    : const Text(
                        'Publish',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 13),
                      ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 60),
          children: [

            // ── Image Upload ──────────────────────────────────
            GestureDetector(
              onTap: () {
                // TODO: image picker
              },
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate_outlined,
                        color: Colors.white24, size: 38),
                    SizedBox(height: 8),
                    Text('Tap to upload service image',
                        style:
                            TextStyle(color: Colors.white38, fontSize: 13)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Service Name ──────────────────────────────────
            _Label('Service Name'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Name is required' : null,
              decoration: _inputDeco('e.g. Sports Complex, Seminar Hall...'),
            ),

            const SizedBox(height: 18),

            // ── Category ─────────────────────────────────────
            _Label('Category'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _categoryController,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Category is required' : null,
              decoration: _inputDeco(
                  'e.g. Sports & Fitness, Academic, Events & Venues...'),
            ),

            const SizedBox(height: 26),

            // ── Amenities ─────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Amenities & Items',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${_amenities.length} added',
                  style:
                      const TextStyle(color: Colors.white38, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Each item will have its own price visible to users',
              style: TextStyle(color: Colors.white24, fontSize: 12),
            ),

            const SizedBox(height: 14),

            // Add amenity row
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _amenityNameController,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Item name',
                            hintStyle: const TextStyle(
                                color: Colors.white38, fontSize: 13),
                            filled: true,
                            fillColor: const Color(0xFF252525),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 11),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _amenityPriceController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: '₹ Price',
                            hintStyle: const TextStyle(
                                color: Colors.white38, fontSize: 13),
                            filled: true,
                            fillColor: const Color(0xFF252525),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 11),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _addAmenity,
                        child: Container(
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.black, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Added amenities list
            if (_amenities.isNotEmpty) ...[
              ..._amenities.asMap().entries.map((entry) {
                final i = entry.key;
                final amenity = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.drag_handle,
                          color: Colors.white24, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          amenity['name'],
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                      ),
                      Text(
                        '₹${(amenity['price'] as double).toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _removeAmenity(i),
                        child: const Icon(Icons.close,
                            color: Colors.white38, size: 18),
                      ),
                    ],
                  ),
                );
              }),
            ] else
              Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: const Center(
                  child: Text(
                    'No items added yet',
                    style: TextStyle(color: Colors.white24, fontSize: 13),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDeco(String hint) => InputDecoration(
        hintText: hint,
        hintStyle:
            const TextStyle(color: Colors.white24, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      );
}

// ─────────────────────────────────────────────────────────────
// LABEL
// ─────────────────────────────────────────────────────────────

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600),
      );
}