enum ImageEnum {
  component(path: 'assets/images/component.png'),
  asset(path: 'assets/images/asset.png'),
  location(path: 'assets/images/location.png');

  final String path;

  const ImageEnum({required this.path});
}
