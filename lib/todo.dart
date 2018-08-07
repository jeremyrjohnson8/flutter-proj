import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';

class ToDoObject {
  String title;
  IconData icon;
  String uuid;
  Color color;
  Map<DateTime, List<TaskObject>> tasks;

  ToDoObject(String title, IconData icon) {
    this.title = title;
    this.icon = icon;
    this.color =
        ColorChoices.colors[new Random().nextInt(ColorChoices.colors.length)];
    this.uuid = new Uuid().v1();
    this.tasks = new Map<DateTime, List<TaskObject>>();
  }

  ToDoObject.import(String uuid, String title, Color color, IconData icon,
      Map<DateTime, List<TaskObject>> tasks) {
    this.title = title;
    this.uuid = uuid;
    this.color = color;
    this.icon = icon;
    this.tasks = tasks;
  }

  int taskAmount() {
    int amount = 0;
    tasks.values.forEach((taskList) {
      amount += taskList.length;
    });
    return amount;
  }

  double percentageCompleted() {
    if (tasks.isEmpty) {
      return 1.0;
    }
    int completed = 0;
    int amount = 0;
    this.tasks.values.forEach((list) {
      amount += list.length;
      list.forEach((task) {
        if (task.isCompleted()) {
          completed++;
        }
      });
    });
    return completed / amount;
  }
}

class TaskObject {
  DateTime date;
  String task;
  bool _complete;

  TaskObject(String task, DateTime date) {
    this.date = date;
    this.task = task;
    this._complete = false;
  }

  TaskObject.import(String task, DateTime date, bool isComplete) {
    this.date = date;
    this.task = task;
    this._complete = isComplete;
  }

  void setComplete(bool isComplete) => _complete = isComplete;

  bool isCompleted() => _complete;
}
