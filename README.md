#Sassquatch

Sassquatch is a Ruby script to quickly create empty .scss files or partials in a directory as well as create or append to an existing _index.scss file the appropriate `@import` of the newly created .scss files.

##Dependencies

* Ruby 2.0.*

##Getting Started

* Replace the `files_to_be_created` variable with newline delimited list of filenames or partials to be created, minus the .scss extension e.g. `_partial.scss` or `test.scss`
* Use Ruby to run the script and enter the destination directory when prompted

##License

Sassquatch is released under the MIT License. See license.txt for more details.