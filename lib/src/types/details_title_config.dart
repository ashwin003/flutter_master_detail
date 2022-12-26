class DetailsTitleConfig {
  final double? titleSpacing;
  final double? collapsedHeight;
  final double? expandedHeight;
  final bool floating, pinned, snap, stretch;

  const DetailsTitleConfig({
    this.titleSpacing,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.stretch = false,
  });
}
