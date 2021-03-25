require 'csv'

def start_app
  puts '1(新規でメモ作成) 2(既存のメモ編集する) 3(ファイルを削除する)'
  result = gets.chomp
  case result
  when '1' 
    create_file
  when '2'
    edit_file
  when '3'
    delete_file
  else
    retry_a
  end
end

# ファイルがすでにあるかどうか
def check
  puts '拡張子を除いたファイルを入力してください'
  $file_name = gets.chomp
  File.exist?("#{$file_name}.csv")
end


def create_file
  # 同じファイル名がなかったら
  if !check
    puts 'メモしたい内容を記入してください'
    memo = gets.chomp
    CSV.open("#{$file_name}.csv",'w') { |f| f << [memo] }
    print "\e[34m"
    puts 'メモを作成しました'
    print "\e[0m"
    start_app
    #同じファイル名が既に存在していたら
  else
    print "\e[31m"
    puts '同じファイル名が既にに存在しています。'
    print "\e[0m"
    create_file
  end
end


def edit_file
  #同じファイル名が存在していたら
  if check
    puts "メモしたい内容を記入してください"
    memo = gets.chomp
    CSV.open("#{$file_name}.csv",'a'){ |f| f << [memo]}
    print "\e[34m"
    puts 'ファイルをを編集しました。'
    print "\e[0m"
    start_app
  else
  # 同じファイル名がなかったら
    print "\e[31m"
    puts  '入力したファイルは存在しません'
    print "\e[0m"
    edit_file
  end  
end


def delete_file
  #同じファイル名が存在していたら
  if check
    File.delete("#{$file_name}.csv")
    print "\e[34m"
    puts 'ファイルを削除しました。'
    print "\e[0m"
    start_app
  else
  # 同じファイル名がなかったら
  print "\e[31m"
    puts  '入力したファイルは存在しません'
    print "\e[0m"
    delete_file
  end  
end


def retry_a
  print "\e[31m"
  puts '1~3の数字を入力してください。'
  print "\e[0m"
  start_app
end

start_app