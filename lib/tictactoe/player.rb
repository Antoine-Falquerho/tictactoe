class Player
	attr_accessor :name, :score, :is_human, :tag

	def initialize name, tag, is_human=false
		@name = name
		@is_human = is_human #is the user an human?
		@tag = tag # Each user has a tag
		@score = 0
	end

end