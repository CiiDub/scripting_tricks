@bbpackage_name  = "Scripting Tricks"
@bbpackage_ext   = ".bbpackage"
@bbpackages_path = "#{Dir.home}/Library/Application Support/BBEdit/Packages"
@project_path    = "#{Dir.pwd}"

# Todo: REFACTOR THIS! Install could be refactored into a method. 
# Todo: Also the setup variables dir_list, src_files ... make a method that returns a hash {dir_list:, src_files:, target_files:} 
namespace :package do
	dir_list = []
	src_files = FileList[
		"#{@project_path}/Contents/Resources/**/*", 
		"#{@project_path}/Contents/Clippings/**/*", 
		"#{@project_path}/Contents/Text Filters/**/*", 
		"#{@project_path}/Contents/Scripts/**/*"
	]
	.each do | f | 
		dir_list << f.gsub( 
		"#{@project_path}", 
		"#{@bbpackages_path}/#{@bbpackage_name}#{@bbpackage_ext}"
		) if File.directory?( f ) 
	end
	.delete_if do |f|
		File.directory?( f )
	end
	target_files = src_files.gsub( 
		"#{@project_path}", 
		"#{@bbpackages_path}/#{@bbpackage_name}#{@bbpackage_ext}"
	)
	
	desc "Deletes Installed Package"
	task :remove do
		if File.exists?( "#{@bbpackages_path}/#{@bbpackage_name}#{@bbpackage_ext}" )
			puts "Deleting #{@bbpackage_name}."
			rm_r( "#{@bbpackages_path}/#{@bbpackage_name}#{@bbpackage_ext}", verbose: false )
		else
			puts "#{@bbpackage_name} isn't installed."
		end
	end
	
	desc "Creates Scripting Tricks package and directory structure."
	task :setup do
		mkdir_p( [
		"#{@bbpackages_path}/#{@bbpackage_name}#{@bbpackage_ext}/Contents/Resources",
		"#{@bbpackages_path}/#{@bbpackage_name}#{@bbpackage_ext}/Contents/Clippings",
		"#{@bbpackages_path}/#{@bbpackage_name}#{@bbpackage_ext}/Contents/Text Filters",
		"#{@bbpackages_path}/#{@bbpackage_name}#{@bbpackage_ext}/Contents/Scripts"
		], verbose: false)
		mkdir_p( dir_list, verbose: false )
	end
	
	desc "Installs Scripts, Text Filters, Clippings, and Resources for #{@bbpackage_name}"
	task :install => [ :setup ] do
		changes_made = false
		src_files.each_with_index do | src_f, index |
			trg_f = target_files[ index ]
			begin
				unless identical?( src_f,  trg_f)
					changes_made = true
					puts "Updating #{trg_f}"
					cp src_f, trg_f
				end
			rescue Errno::ENOENT
				changes_made = true
				puts "Makeing new file #{trg_f}."
				cp( src_f, trg_f, verbose: false )
			end
		end
		if changes_made
			puts "A fresh install"
		else
			puts "No changes made to #{@bbpackage_name}"	
		end
	end
end

namespace :stationery do
	dir_list = []
	src_files = FileList["#{@project_path}/Stationery/**/*"]
	.each do | f | 
		dir_list << f.gsub( 
		"#{@project_path}", 
		"#{Dir.home}/Library/Application Support/BBEdit/"
		) if File.directory?( f ) 
	end
	.delete_if do |f|
		File.directory?( f )
	end
	target_files = src_files.gsub( "#{@project_path}", "#{Dir.home}/Library/Application Support/BBEdit/" )
	
	desc "Deletes Installed Stationery Files."
	task :remove do
		target_files.each do | trg_f |
			if File.exists? trg_f
				puts "Removing stationery file #{trg_f}"
				rm( trg_f, verbose: false )
			end
		end
		puts "Stationery long gone."
	end
	
	desc "Installs files into BBEdits Stationery folder."
	task :install do
		changes_made = false
		src_files.each_with_index do | src_f, index |
			trg_f = target_files[ index ]
			begin
				unless identical?( src_f,  trg_f)
					changes_made = true
					puts "Updating #{trg_f}"
					cp src_f, trg_f
				end
			rescue Errno::ENOENT
				changes_made = true
				puts "Makeing new stationery file #{trg_f}."
				cp( src_f, trg_f, verbose: false )
			end
		end
		if changes_made
			puts "Stationery freshly installed"
		else
			puts "No changes made."	
		end
	end
end