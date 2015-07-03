#######################################################
#                         q4                          #
#######################################################

# s = ['hoge', 'hoge', 'foo', 'bar', 'foo', 'hoge']
def count_up(s)
  count = Hash.new
  (0...s.size).each do |i|
    # hoge, hoge, foo, bar, foo, hoge -> s[i]
    # ||= -> もしもNULLだったら値を代入する
    # count['hoge'] <- nil => count['hoge'] = 0
    count[s[i]] ||= 0
    count[s[i]] += 1
  end

  # 降順にソート
  # hash = { key: value }
  count = count.sort_by { |k, v| -v }
  # count = [['hoge', 3], ['foo', 2], ['bar', 1]]
  count.each do |c|
    # c -> ['hoge', 3], ['foo', 2]
    # c[0] -> hoge, foo
    # c[1] -> 3, 2
    puts "#{c[0]}\t#{c[1]}"
  end
end

#######################################################
#                         q1                          #
#######################################################

s = File.read('doc.txt', :encoding => Encoding::UTF_8)
# p -> debug用，改行文字などが\r\nで表示される
# puts -> 普通の表示用，改行は普通に改行されて表示される

# 1. 大文字を小文字に統一
# str = 'HOGE'
# str.downcase
# => hoge
# p str
# => HOGE このように次の状態では戻ってしまう
# str.downcase!
# => hoge
# p str
# => hoge !をつけると自分自身を破壊的に変更できる
s.downcase!
# 2. (,),"を除去
s.gsub!('(', '')
s.gsub!(')', '')
s.gsub!('"', '')

s.gsub!(',', '')
s.gsub!('.', '')

# 3. -を除去して単語に分割
s.gsub!('-', ' ')

# 4. 文末のアポストロフィを削除
# princess' surprise
# surprise princess'\r\n
s.gsub!("' ", ' ')
# 改行記号などの特殊文字は""で囲む必要がある
s.gsub!("'\r\n", ' ')

# 1行を1単語に変換
s.gsub!(' ', "\r\n")

# 先頭の行を排除
s = s.split("\r\n")
s.shift

puts s

puts "=============================== q5-> (1)  ====================================="
count_up(s)
puts "=============================== q5-> (1)  ====================================="

#######################################################
#                         q2                          #
#######################################################

# 指定されたストップワードを排除する機能を実装する
stop = File.read('stop_words_list.txt', :encoding => Encoding::UTF_8)

# splitは指定した文字を区切って配列に変換する
stop = stop.split("\r\n")

# 配列0番目からsのサイズまでiをループさせる
# s = ['hoge', 'foo', 'bar']
# stop = ['foo', 'bar']
(0...s.size).each do |i|
  # i -> 1 => s[i] -> 'foo'
  # ['foo', 'bar'].include?('foo') => true
  if stop.include?(s[i])
    # s[1] -> 'foo'
    # s.delete(s[1]->'foo')
    # s = ['hoge', 'bar']
    s.delete(s[i])
  end
end

puts s

puts "=============================== q5-> (2)  ====================================="
count_up(s)
puts "=============================== q5-> (2)  ====================================="

#######################################################
#                         q3                          #
#######################################################

# http://chalow.net/2008-01-20-1.html
# 上記を参照したルールに則って置換する
# /hogehoge$/の$はhogehogeで文末が終わるものという正規表現になる
# また，ssで終わるものを除去するとルールに則っていないので，
# ssで終わるものはそのままにし，s単体で終わるものはsを除去するというif-else文が必要となる
(0...s.size).each do |i|
  s[i].gsub!(/sses$/, 'ss')
  s[i].gsub!(/ies$/, 'i')
  if s[i] =~ /ss$/
    s[i].gsub!(/ss$/, 'ss')
  elsif s[i] =~ /s$/
    s[i].gsub!(/s$/, '')
  end
end

puts s

puts "=============================== q5-> (3)  ====================================="
count_up(s)
puts "=============================== q5-> (3)  ====================================="
