require 'csv'

# インポートファイルを読み込む
def import_read(file_name)
  lines = CSV.read("db/fixtures/#{Rails.env}/#{file_name}")
  lines.unshift([]) # index 0番目は空行を入れてスキップさせる

  lines.each_with_index do |line, idx|
    next unless line.length.positive?

    yield(line, idx) if block_given?
  end
end

# CSVファイルの取込
import_read('code.csv') do |line, idx|
  Code.seed do |s|
    s.id         = idx
    s.code_id    = line[0]
    s.sub_id     = line[1]
    s.code       = line[2]
    s.name       = line[3]
    s.created_at = line[4]
    s.updated_at = line[5]
  end
end
