# Implement the following read-only attributes in the Solution class.
  #* highest_count_across_lines - a number with the value of the highest frequency of a word
  #* highest_count_words_across_lines - an array with the words with the highest frequency

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers
  #* calculate_line_with_highest_frequency() - determines which line of
  #text has the highest number of occurrence of a single word
  #* print_highest_word_frequency_across_lines() - prints the words with the 
  #highest number of occurrences and their count
  
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the highest number of occurences of a word across all lines
  #and stores this result in the highest_count_across_lines attribute.
  #* identifies the words that were used with the highest number of occurrences
  #and stores them in print_highest_word_frequency_across_lines.

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the result in the following format
class LineAnalyzer
  attr_reader :content, :line_number, :highest_wf_words, :highest_wf_count
  
  def initialize (content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_words = []
    calculate_word_frequency
  end
  def calculate_word_frequency
    word_frequency = Hash.new(0)
    @content.split.each do |word|
      word_frequency[word.downcase] += 1
    end
    @highest_wf_count = word_frequency.values.max
    word_frequency.each do |k,v|
      @highest_wf_words << k if @highest_wf_count == v
    end
  end
end

#  Implement a class called Solution. 
class Solution
  attr_reader :highest_count_across_lines, :highest_count_words_across_lines, :analyzers
  
  def initialize
    @analyzers = []
  end
  
  def analyze_file()
    count = 0
    File.foreach('test.txt') do |line|
      @analyzers << LineAnalyzer.new(line.chomp, count+=1)
    end
  end
  
  def calculate_line_with_highest_frequency ()
    @highest_count_across_lines = @analyzers.max_by do |element|
      element.highest_wf_count
    end.highest_wf_count
    @highest_count_words_across_lines = []
    @analyzers.each do |la|
      @highest_count_words_across_lines << la if la.highest_wf_count == @highest_count_across_lines
    end
  end  
  
  def print_highest_word_frequency_across_lines
    @highest_count_words_across_lines.each_pair do |line, words|
      words.each { |w| puts w }
      puts line
    end
  end
end
