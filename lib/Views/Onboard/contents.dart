class Content {
  final String title;
  final String description;

  Content(this.title, this.description);
  static List<Content> contents = [
    Content("Now you can more quickly and easily track your vehicle",''),
    Content('For tracking your daily costs', 'Description 2'),
    Content('Your work expenses', 'Description 3'),
  ];
}