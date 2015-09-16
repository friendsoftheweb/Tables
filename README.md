## Project Purpose

A simple project employing a table view backed by a Core Data model and fetched results controller built for experimentation and debugging of discrepancies in `NSFetchedResultsController`, `UITableview`, and/or something else in core data which results in different behavior in iOS versions circa 8.3, 8.4, and 9.0.

These discrepancies are causing crashes and other issues in fetched result controller backed table views in some of our apps. See [this forum post](https://forums.developer.apple.com/thread/4999) regarding the issue.

Although distinct behavior can be observed between different OS versions, the exact nature of the problem has not yet become clear; however, the intention is to submit a bug report with this sample project if it does.


## Project Structure

The application is intended to be the smallest possible implementation which demonstrates the problem. The application consists of a single table view backed by a fetched results controller using an in memory managed object context.

The table lists 'tasks' which contain a name, date, and completion state. Tapping a bar item creates some random tasks. Tapping cells toggles that task's completion state. Tasks are sorted first by their completion state and then by their date. Interactions with the table view do not, obviously, work quite right.
