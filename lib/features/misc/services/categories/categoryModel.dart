class Category {
  final String id;
  final String name;
  final String slug;
  final int level;
  final String? parentId;
  final String? icon;
  final int order;
  final String? description;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.level,
    this.parentId,
    this.icon,
    required this.order,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      level: json['level'],
      parentId: json['parentId'],
      icon: json['icon'],
      order: json['order'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'slug': slug,
        'level': level,
        'parentId': parentId,
        'icon': icon,
        'order': order,
        'description': description,
      };
}
