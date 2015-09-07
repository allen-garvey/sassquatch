# Script to init sass partials in a directory and register them in an _index.scss file

# filename minus .scss extension - e.g. _header or test
files_to_be_created = <<-eof
_header
_nav
something.scss
_main.scss
eof

puts "\n\n**************\n"
puts "Sassquatch is a script to initialize a directory with scss files, as well as an _index.scss partial"
puts "If there is already an _index.scss file in the directory, don't worry, we will just append to it.\n\n"
puts "Please enter the destination directory to be initialized:"

target_directory = gets.chomp

# clean up target directory input
target_directory.gsub!(/\/?[\s\t\n]*$/, '')
# unescape spaces since we're putting the command in quotes
target_directory.gsub!(/\\\s/, ' ')
target_directory = target_directory + '/'

index_import_string = ''

files_to_be_created.split("\n").each do |file|
	file.gsub!(/[\n\t\s]+$/, '')
	if file !~ /\.scss$/
		filename = file + '.scss'
	else
		filename = file	
	end
	process_succeeded = system("touch \"#{target_directory}#{filename}\"")
	index_import_string = index_import_string + "@import \"#{filename}\";\n"
end

# create _index.scss append imports for new .scss partials at the end
index_path = target_directory + '_index.scss'
process_succeeded = system("touch \"#{index_path}\"")
process_succeeded = system("echo '#{index_import_string}' >> \"#{index_path}\"")