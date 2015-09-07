#Sassquatch

Sassquatch is a command-line program to quickly initialize empty .scss files or partials in a directory as well as create or append to an existing _index.scss file the appropriate `@import` for those newly created .scss files.

##Dependencies

* Ruby 2.0.*

##Getting Started

* To run Sassquatch, type `ruby path/to/sassquatch/sassquatch.rb` followed by arguments
* Sassquatch takes two arguments: a comma-delimited list of filenames to be created (if there are commas in the filenames surround the whole list in quotes), and the directory to create them in
* A full example would be: `ruby path/to/sassquatch/sassquatch.rb test.scss,_nav,_header.scss ~/Sites/test_site/sass`
* The arguments `-help` and `-v` are also used to display help, or version number respectively

##License

Sassquatch is released under the MIT License. See license.txt for more details.