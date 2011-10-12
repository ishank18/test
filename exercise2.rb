def compressStyle(*args)
	begin
		input_file = IO.read(args[0])
		output_string = String.new()
		i = 0
		on_comment = false
		while i < input_file.length-1
			if(input_file[i] == "/" && input_file[i+1] == "*")
				on_comment = true
			end
			if(input_file[i] == "*" && input_file[i+1] == "/")
				on_comment = false
				i += 2
			end
			repeated_newline = 0
			if(on_comment == false)
				if(input_file[i].ord == 10)
					if(input_file[i+1].ord == 10)
						i += 1
						repeated_newline = 1
					else
						if(input_file[i+1] != "/" && input_file[i+2] != "*")
							repeated_newline = 0
							output_string[output_string.length] = " "
						end	
					end	
				elsif(input_file[i].ord == 9)
					output_string[output_string.length] = ""	
				else
					output_string[output_string.length] = input_file[i]
				end
			end
			if(repeated_newline == 0)
				i += 1
			end	
		end
		yield(output_string)
		rescue => e
			puts "\nError Occured : #{e}\n\n"
	end	
end
print "Enter the input file name : "
input_file = gets.chomp
compressStyle(input_file) { |output_string|
	print "Enter the output file : "
	output_file = gets.chomp
	if(FileTest.exists?(output_file))
		print "File named #{output_file} already exist, do you want to overwrite (y) ? "
		prompt = gets.chomp
		if(prompt == "y" || prompt == "Y")
			op_file = File.new(output_file, "w")
			op_file.puts output_string
			puts "\n#{output_file} successfully overwritten!\n\n"
		else
			puts "\nNothing Effected\n\n"
		end
	else
		print "File named #{output_file} does not exists, do you want to create a new file (y) ? "
		prompt = gets.chomp
		if(prompt == "y" || prompt == "Y")
			op_file = File.new(output_file, "w")
			op_file.puts output_string
			puts "\n#{output_file} successfully created! \n\n"
		else
			puts "\nNothing Effected\n\n"
		end
	end	
}

