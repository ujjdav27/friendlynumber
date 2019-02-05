require 'benchmark'
class HumanFriendlyNumber
  # loading dictionary text into a hash map to allow O(1) lookup time 
  @@dict_map = {}
  Benchmark.bm do |bm|
    bm.report do
      DICTIONARY = File.readlines('dictionary.txt').map { |w| w.chomp.downcase }
      DICTIONARY.each do |word|
        @@dict_map[word] = 1
      end
    end
  end
  def initialize
    @h = {}
    @h['2'] = %w(a b c)
    @h['3'] = %w(d e f)
    @h['4'] = %w(g h i)
    @h['5'] = %w(j k l)
    @h['6'] = %w(m n o)
    @h['7'] = %w(p q r s)
    @h['8'] = %w(t u v)
    @h['9'] = %w(w x y z)
  end

  private
  # this method gets the word for first and second part and checks for combination of word 
  # against the dictionary to find the result word 
  def get_words_from_char_array(final_char_array, result_array, result)
    first_word_array = []
    second_word_array = []
    first_char_array = final_char_array[0]
    second_char_array = final_char_array[1]
    first_word_array = get_word_array(first_char_array)
    second_word_array = get_word_array(second_char_array) unless first_word_array.empty?
    unless first_word_array.empty? && second_word_array.empty?
      first_word_array.each do |word1|
        second_word_array.each do |word2|
          final_word = word1 + word2
          if @@dict_map[final_word]
            result = final_word
          else
            result_array << [word1, word2]
          end
        end
      end
    end
    result
  end
  # this method helps getting all the combination of words formed by using char array corresponding
  # to each number, only those words which are found in dictionary are processed further, remaining
  # are ignored
  def get_word_array(char_array)
    my_words_final_array = []
    result_final_array = []
    n = 0
    for i in 0..char_array.length - 2
      my_words_final_array = []
      my_words_array = char_array[0] if n == 0
      n += 1
      my_words_array.each do |word|
        char_array[n].each do |char|
          temp_word = word + char
          my_words_final_array << temp_word
          result_final_array << temp_word if temp_word.length >= char_array.length && @@dict_map[temp_word]
        end
      end
      my_words_array = []
      my_words_final_array.each do |word|
        my_words_array << word.dup
      end
    end
    result_final_array
  end

  def divide_number_in_two_parts(n)
    number = n.chomp.to_i
    divisor = 10_000_000
    number_final_array = []
    for i in 1..5
      part_one = number / divisor
      part_two = number % divisor
      number_final_array << [part_one, part_two]
      divisor /= 10
    end
    number_final_array
  end

  def get_char_arrays_for_divided_numbers(number_final_array)
    arr_final_char_array = []
    number_final_array.each do |number_pair|
      part_one_strings = []
      part_two_strings = []
      final_char_array = []
      number_pair.each do |number|
        number_str = number.to_s
        char_array = []
        number_str.each_char do |char|
          char_array << @h[char]
        end
        final_char_array << char_array
      end
      arr_final_char_array << final_char_array
    end
    arr_final_char_array
  end

  public

  def find_string_for_number(n)
    # divide 10 digit number in 2 parts of length (3,7), (4,6), (5,5), (6,4), (7,3)
    number_final_array = divide_number_in_two_parts(n)
    # getting char array corresponding to split number 
    arr_final_char_array = get_char_arrays_for_divided_numbers(number_final_array)
    result_array = []
    result = ''
    # getting words found in dictionary made from the combination of char arrays
    arr_final_char_array.each do |final_char_array|
      result = get_words_from_char_array(final_char_array, result_array, result)
    end
    result_array.sort!
    result_array << result unless result.empty?
    puts result_array.inspect
    [result, result_array]
  end
end
