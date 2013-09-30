

def add_to_black_list(array)
  array.uniq!

  array.each do |item|
    @file = File.open('black_list.txt' , 'a')
    @file.puts item
  end

  # @file.close
  # array.each do |el|
  #   @black_list << el
  # end
end

def open_black_list
  File.open('black_list.txt').each_line do |line|
    @black_list << line.strip
    # p @black_list
  end
end