require "csv"

puts "1(新規でメモを作成) 2(既存のメモを編集する)"

memo_type = gets.to_s.chomp

#新規作成の場合
if memo_type == "1"
 puts "【新規】拡張子を除いたファイル名を入力してください。"
 file_name = gets.chomp
 #入力したファイル名が存在する場合終了する
 if File.exist?("#{file_name}.csv")
  puts "そのファイル名は存在します。"
  puts "別のファイル名を指定してください。"
  exit
 end
 
 #ファイル名が存在しない場合書き込み
 puts "メモしたい内容を記入してください。"
 puts "完了したらCtrl+Dを押します。"
 
 memo = STDIN.read
 
 CSV.open("#{file_name}.csv","w") do |csv|
 csv << [memo]
 end

#編集の場合 
elsif memo_type == "2"
 puts "【編集】拡張子を除いたファイル名を入力してください。"
 file_name = gets.chomp
 
 #編集したいファイル名が存在する場合、内容を表示する
 if File.exist?("#{file_name}.csv")
  puts "---------------"
  puts CSV.read("#{file_name}.csv")
  puts "---------------"
  
  puts "追記したい内容を記入してください。"
  puts "完了したらCtrl+Dを押します。"
   
  memo = STDIN.read
  
  #追記モード
  CSV.open("#{file_name}.csv","a") do |csv|
  csv << [memo]
  end

 #編集したいファイル名が存在しない場合処理を終了する
 else
  puts "そのファイル名は存在しません。"
  puts "別のファイル名を指定してください。"
  exit
 end

#1もしくは2以外を入力した場合処理を終了する
else
 puts "1または2を入力してください。"
end