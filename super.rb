def count_up(list)
  hash = {}
  (0...list.size).each do |i|
    hash[list[i]] ||= 0
    hash[list[i]] += 1
  end
  hash.sort_by { |_, v| -v }.each { |line| puts "#{line[0]}\t#{line[1]}" }
end

doc = File.read('./doc.txt')
list = doc.downcase.gsub('(', '').gsub(')', '').gsub('"', '').gsub('-', ' ').gsub("' ", ' ').gsub(',', '').gsub('.', '').gsub("'\r\n", ' ').gsub(' ', "\r\n").split("\r\n")
list.shift
puts list
count_up(list)

stop_word_list = File.read('./stop_words_list.txt').split("\r\n")
(0...list.size).each { |i| list.delete(list[i]) if stop_word_list.include?(list[i]) }
puts list
count_up(list)

def stem(list, i)
  list[i].gsub!(/sses$/, 'ss')
  list[i].gsub!(/ies$/, 'i')
  if list[i] =~ /ss$/
    list[i].gsub!(/ss$/, 'ss')
  elsif list[i] =~ /s$/
    list[i].gsub!(/s$/, '')
  end
end
(0...list.size).each { |i| stem(list, i) }
puts list
count_up(list)
