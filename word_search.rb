require 'pp'

def straight_line_include?(word, puzzle)

  starting_points  = []
#list of surrounding coordinates in a 2d array
  directions = [
    [1,0],
    [0,1],
    [1,1],
    [-1,-1],
    [-1,0],
    [0,-1],
    [1,-1],
    [-1,1]
  ]

  #Search through the 2d array seeking all positions with a letter that matches first letter of the word
  puzzle.each_with_index do |row,row_index|
    row.each_with_index do |char,col_index|
      if  char == word[0]
        starting_points << [row_index,col_index]
      end
    end
  end

  #handle nil return
  if starting_points[0].nil?
    return false
  end

  starting_points.any? do |point|
    # check if there any starting points...
    directions.any? do |direction|
      # ...from which in any single direction...
      word.split('').each_with_index.all? do |char,index|
        #... all of the chars in that direction match
        # calculate next point to check (rechecks starting point too)
        row_index = point[0] + index * direction[0]
        col_index = point[1] + index * direction[1]

        #stay within bounds of the 2d array
        if row_index > (puzzle.length - 1) || col_index >( puzzle[0].length - 1) || row_index < 0 || col_index < 0
          false
        elsif puzzle[row_index][col_index] == char
          # keep going
          true
        else
          false
        end
      end
    end
  end
end

#recursively seek out answer, continuing until all starting positions have been checked or solution found
def snaking_include?(word, puzzle, i = 0,coordinates_to_check = [])
  #Each time a letter match is found i is incremented by 1
  #Without classes only way to make data persist in the recursive method is to include as an argument
  return true if i == word.length

  if coordinates_to_check == []
    # If we have no coordinates to check find the first letter starting point
    coordinates_to_check = find_starting_coordinates(word[0],puzzle)
  end

  #if a matching letter is found continue seeking matches in all directions at next coordinate
  coordinates_to_check.any? do |coordinate|
    if puzzle[coordinate[0]][coordinate[1]] == word[i]
     neighbors = get_next_coordinates(coordinate,puzzle)
     snaking_include?(word, puzzle, i + 1, neighbors)
   end
 end
end

def find_starting_coordinates(first_letter,puzzle)
  starting_coordinates = []
  puzzle.each_with_index do |row,row_index|
    row.each_with_index do |letter,column_index|
      if first_letter == letter
         starting_coordinates << [row_index,column_index]
      end
    end
  end
  starting_coordinates
end

def get_next_coordinates(current_position,puzzle)
  directions = [
    [1,0],
    [0,1],
    [1,1],
    [-1,-1],
    [-1,0],
    [0,-1],
    [1,-1],
    [-1,1]
  ]

  next_coordinates = directions.map {|direction| [current_position[0] + direction[0],current_position[1] + direction[1]]}

  next_coordinates.reject{|coordinate| ((coordinate[0] > (puzzle.length - 1)) || (coordinate[1] >( puzzle[0].length - 1) )|| (coordinate[0] < 0) || (coordinate[1] < 0))}
end



def interface()

  pp puzzle = [
    ["a", "k", "f", "o", "x", "e", "s"],
    ["s", "o", "a", "w", "a", "h", "p"],
    ["i", "t", "c", "k", "e", "t", "n"],
    ["o", "t", "s", "d", "h", "o", "h"],
    ["s", "e", "x", "g", "s", "t", "a"],
    ["u", "r", "p", "i", "w", "e", "u"],
    ["z", "s", "b", "n", "u", "i", "r"]
  ]
  puts "What word do you want to find?"
  word_to_find = gets.chomp
  result = snaking_include?(word_to_find,puzzle)
  if result
    puts "Found Your Word! Score!"
    pp puzzle
  else
    puts "Word Not Found"
    puts "Fail blog!"
  end
end



