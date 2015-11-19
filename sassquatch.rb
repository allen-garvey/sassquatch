# Script to init sass partials in a directory and register them in an _index.scss file
# argument 0 is a comma delimiter list of filenames to be created, with or without .scss extension
# argument 1 is directory where the files and _index.scss with imports are to be placed
# the script is non-destructive, so that existing files will not be deleted or overwritten
# and an existing _index.scss file will only be appended to

program_name = "Sassquatch"
version_number = "0.2.0"
argument_list = "\t[0] comma delimited list of filenames and\n\t[1] target directory for new .scss files"

def exit_with_msg(msg, program_name, argument_list)
	abort "\n#{program_name} #{msg}\n\tArguments required:\n#{argument_list}"
end

if ARGV.length > 0 and ARGV[0] =~ /[-]+help$/
	exit_with_msg("\nInitialize a directory with .scss files and an _index.scss file importing them", program_name, argument_list)
elsif ARGV.length > 0 and ARGV[0] =~ /[-]+v(ersion)?$/
	abort "\n#{program_name} version #{version_number}"
elsif ARGV.length < 2
	exit_with_msg('error missing arguments', program_name, argument_list)
elsif ARGV.length > 2
	exit_with_msg('error too many arguments given', program_name, argument_list)
elsif ARGV[1] =~ /\.scss|^_/
	wrong_arg = ARGV[1].match(/\.scss|^_.*/)[0]
	exit_with_msg("error no target directory given (argument[1] {#{wrong_arg}} inferred to be .scss file)", program_name, argument_list)
end

files_to_be_created = ARGV[0].dup #requires .dup because of frozen string
target_directory = ARGV[1].dup

#cleans input by removing trailing whitespace and forward slash 
#and un-escaping escaped spaces
def clean_bash_input(input)
	cleaned_input = input.gsub(/\/?[\s\t\n]*$|^[\n\t\s]+/, '')
	cleaned_input.gsub(/\\\s/, ' ')
end

target_directory = clean_bash_input(target_directory)
target_directory = target_directory + '/' #add back trailing slash since clean_bash_input removes it

index_import_string = ''

files_to_be_created.split(",").each do |file|
	file = clean_bash_input(file)
	if file !~ /\.scss$/
		filename = file + '.scss'
	else
		filename = file	
	end
	process_succeeded = system("touch \"#{target_directory}#{filename}\"")
	# add doc comment at top
	doc_comment = <<-eos
/*
* Styles for #{file.gsub(/^_/, '')}
*/
eos
	process_succeeded = system("echo \"#{doc_comment}\" >> \"#{target_directory}#{filename}\"")
	index_import_string = index_import_string + "@import \"#{filename}\";\n"
end

# create _index.scss append imports for new .scss partials at the end
index_path = target_directory + '_index.scss'
process_succeeded = system("touch \"#{index_path}\"")
process_succeeded = system("echo '#{index_import_string}' >> \"#{index_path}\"")