-- _ENV.input is a line iterator for the day's puzzle
-- _ENV.split is a string split function
-- "return" your answer

for line in input do
	print(table.concat(split(line, " "), ", "))
end

return "answer"
