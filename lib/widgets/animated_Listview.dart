// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedListView extends StatefulWidget {
  AnimatedListView({
    Key? key,
    required this.children,
    this.physics,
    this.padding,
    this.reverse = false,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.itemExtent,
    this.shrinkWrap = false,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key) {
    Set<Key> identical = {};
    for (final child in children) {
      if (child.key == null) {
        throw "You must give each widget a key.";
      }
      if (identical.contains(child.key)) {
        throw "Each widget key must be unique.";
      }

      identical.add(child.key!);
    }
  }

  final List<Widget> children;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool reverse;
  final ScrollController? controller;
  final Axis scrollDirection;
  final double? itemExtent;
  final bool shrinkWrap;
  final Duration duration;

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  late final Map<Key, Timer> timers;
  late final Map<Key, double> opacities;
  late List<Widget> children;

  @override
  void initState() {
    children = widget.children;
    opacities = Map.fromEntries(children.map((e) => MapEntry(e.key!, 0)));
    final halfDuration = (widget.duration.inMilliseconds / 2).floor();

    timers = Map.fromEntries(children.asMap().entries.map((kv) => MapEntry(
        kv.value.key!,
        Timer(
          Duration(milliseconds: halfDuration + halfDuration * kv.key),
          () {
            opacities[kv.value.key!] = 1.0;
            setState(() {});
          },
        ))));

    super.initState();
  }

  @override
  void dispose() {
    for (final timer in timers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedListView oldWidget) {
    final toDeleted = <Widget>[];
    final toAdded = <Widget>[];

    for (final old in oldWidget.children) {
      if (!widget.children.any((e) => e.key == old.key)) {
        toDeleted.add(old);
      }
    }

    for (final child in widget.children) {
      if (!oldWidget.children.any((e) => e.key == child.key)) {
        toAdded.add(child);
      }
    }

    for (final child in toDeleted) {
      timers[child.key]?.cancel();
      opacities[child.key!] = 0;
      setState(() {});
      timers[child.key!] = Timer(
        widget.duration,
        () {
          timers.remove(child.key);
          opacities.remove(child.key);
          children.removeWhere((e) => e.key == child.key);
          setState(() {});
        },
      );
    }

    for (final child in toAdded) {
      timers[child.key]?.cancel();
      opacities[child.key!] = 0;
      final idx = widget.children.indexOf(child);
      children.insert(idx, child);
      setState(() {});
      timers[child.key!] = Timer(
        widget.duration,
        () {
          opacities[child.key!] = 1.0;
          setState(() {});
        },
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      controller: widget.controller,
      reverse: widget.reverse,
      padding: widget.padding,
      scrollDirection: widget.scrollDirection,
      itemExtent: widget.itemExtent,
      children: children
          .map(
            (e) => AnimatedOpacity(
              key: ValueKey(e.key),
              opacity: opacities[e.key!]!,
              duration: const Duration(milliseconds: 200),
              child: e,
            ),
          )
          .toList(),
    );
  }
}
