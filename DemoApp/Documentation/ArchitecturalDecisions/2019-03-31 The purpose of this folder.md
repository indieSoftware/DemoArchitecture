# The purpose of this folder

This document describes what this folder is good for and how the files in it are to be written.

Written by Sven Korset 2019-03-31.

## Context

Without a document describing any architectural descisions people will forget why they should write code in a specific way. It also helps improving the maintainability and to get new programmers into the project.

Therefore the goal of this architectural decisions folder is to keep track of the decisions made how the project has to be architecturally structured. So this folder contains documents describing these decisions made.

For the source of inspiration and a detailed description of the idea behind it read [https://github.com/nshift/ios-guidelines/blob/master/README.md#what-is-an-adr](https://github.com/nshift/ios-guidelines/blob/master/README.md#what-is-an-adr)

## Decision

Each architectural decision in this project should be written down in its own document file and saved in this folder.

* The file's name starts with the date as YYYY-MM-DD. This is ISO standard and helps for sorting by date.
* The file's name contains a short title describing to get a hint what this file contains.
* The name uses sentence capitalization and spaces. This is helpful for readability.
* The extension is markdown. This can be useful for easy formatting.
* When an architectural decision has been made or changed it has to be written down in its corresponding file.

**Example:**

```
2019-03-31 The purpose of this folder.md
```

### Structure of a document

The structure of the document should be very simple:

* Title: short phrase, less than 50 characters, like a git commit message, just to get an overview.
* Context: what is the issue that we're seeing that is motivating this decision or change.
* Decision: what is the change that we're actually proposing or doing.
* Consequences: what becomes easier or more difficult to do because of this change.

The Decision section is the most important section of the document. It will describe why, how and what the dicision is about. It should contain examples and sample code.

As an example use this file.

## Consequences

* A track list of decisions made.
* An entry point to get up-to-date insights of the app's structure.
* When a architectural decision has been made or changed it has to be written down in the corresponding file.
