@bbpackages_path = "#{Dir.home}/Library/Application Support/BBEdit/Packages"
@bbpackage_name  = "Scripting Tricks"
@bbpackage_ext   = ".bbpackage"
@bbpackage       = "#{@bbpackages_path}/#{@bbpackage_name}#{@bbpackage_ext}"
@project_path    = "#{Dir.pwd}"

def get_src_and_trg_files ( search_list: [], working_dir: @project_path, install_dir: @bbpackage )
	output = { src_list: [], dir_list: [], trg_list: [] }
	
	output[ :src_list ] = search_list.each do | f | 
		output[ :dir_list ] << f.gsub( working_dir, install_dir ) if File.directory?( f )
	end
	.delete_if { | f | File.directory?( f ) }
	
	output[ :trg_list ] = output[ :src_list ].gsub( working_dir, install_dir )
	return output
end

def installed? ( src_files, target_files)
	changes_made = false
	src_files.each_with_index do | src_f, index |
		trg_f = target_files[ index ]
		begin
			unless identical?( src_f,  trg_f)
				changes_made = true
				puts "Updating #{trg_f}"
				cp( src_f, trg_f, verbose: false )
			end
		rescue Errno::ENOENT
			changes_made = true
			puts "Makeing new file #{trg_f}."
			cp( src_f, trg_f, verbose: false )
		end
	end
	return changes_made
end

namespace :package do
	folders = FileList[
		"#{@project_path}/Contents/Resources/**/*", 
		"#{@project_path}/Contents/Clippings/**/*", 
		"#{@project_path}/Contents/Text Filters/**/*", 
		"#{@project_path}/Contents/Scripts/**/*"
	]
	
	setup        = get_src_and_trg_files( search_list: folders )
	dir_list     = setup[:dir_list]
	src_files    = setup[:src_list]
	target_files = setup[:trg_list]
	
	desc "Deletes Installed Package"
	task :remove do
		if File.exists?( "#{@bbpackage}" )
			puts "Deleting #{@bbpackage_name}."
			rm_r( "#{@bbpackage}", verbose: false )
		else
			puts "#{@bbpackage_name} isn't installed."
		end
	end
	
	desc "Creates Scripting Tricks package and directory structure."
	task :setup do
		mkdir_p( [
		"#{@bbpackage}/Contents/Resources",
		"#{@bbpackage}/Contents/Clippings",
		"#{@bbpackage}/Contents/Text Filters",
		"#{@bbpackage}/Contents/Scripts"
		], verbose: false)
		mkdir_p( dir_list, verbose: false )
	end
	
	desc "Installs Scripts, Text Filters, Clippings, and Resources for #{@bbpackage_name}. Runs as a prereq for package:install"
	task :install => [ :setup ] do
		if installed?( src_files, target_files )
			puts "A fresh install"
		else
			puts "No changes made to #{@bbpackage_name}"	
		end
	end
end

namespace :stationery do
	folders      = FileList["#{@project_path}/Stationery/**/*"]
	setup        = get_src_and_trg_files( search_list: folders, install_dir: "#{Dir.home}/Library/Application Support/BBEdit/" )
	src_files    = setup[:src_list]
	target_files = setup[:trg_list]

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
		if installed?( src_files, target_files )
			puts "Stationery freshly installed"
		else
			puts "No changes made to stationery files."	
		end
	end
end