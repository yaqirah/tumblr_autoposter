#fuction definitions
def get_file(file, file_path)
	found = false
	random = 0
	
	print "Searching for a file to post"
	
	while(!found) #continue until generated file exists
		#get jojo part
		random = rand(4..5)
		case random
			when 4 then file = "part4"
			when 5 then file = "part5"
		end
		
		#get source type
		random = rand(1..2)
		case random
			when 1 then file += "_anime"
			when 2 then file += "_manga"
		end
		
		#get episode/chapter number
		if file.include?("anime")
			file += "_ep" + rand(1..20).to_s #part 4 anime has more eps but i only ripped 20
		elsif file.include?("manga")
			if file.include?("part4")
				file += "_chpt" + rand(1..174).to_s
			elsif file.include?("part5")
				file += "_chpt" + rand(1..155).to_s #get first and last chapter koichi appeared in during part 5 later
			end
		end
		
		#get file number
		file += "_" + rand(1..250).to_s
		
		file += ".png"
		
		print "." #print a dot for each file checked so the user knows its doing something
		
		if File.exists?(file_path + file)
			found = true
			puts "\n" + file + " exists, posting..."
			return file
		end
	end
end
def tag_post(file, tags)
	tags.push("jjba", "Jojo's Bizarre Adventure", "Koichi Hirose") #add tags that are always included

	#add the rest of the tags based off of the file name
	if file.include?("part4")
		tags.push("Diamond is Unbreakable")
	elsif file.include?("part5")
		tags.push("Vento Aureo")
	end

	if file.include?("anime")
		tags.push("anime")
	elsif file.include("manga")
		tags.push("manga")
	end
	return tags
end