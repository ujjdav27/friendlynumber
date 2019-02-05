input_arr = ARGV
if input_arr.empty? || input_arr.length > 1
  puts "Enter the input 10 digit number as command line argument while executing the program!"
  exit
end
if input_arr[0].length != 10
  puts "Enter only 1 input number with 10 digits without (0 and 1)!"
  exit
end
if (input_arr[0].include? "0") || (input_arr[0].include? "1")
  puts "Enter only number with 10 digits without (0 and 1)!"
  exit
end
require '.\dict_modular'
n = input_arr[0]
if n.chomp.length != 10
  puts 'Please enter a 10 Digit Number with (0 and 1)!!!'
else
  myobj = HumanFriendlyNumber.new
  result = ''
  Benchmark.bm do |bm|
    bm.report do
      result, result_array = myobj.find_string_for_number n
    end
  end
  puts "Human Friendly number for #{n.chomp} is #{result}"
end
