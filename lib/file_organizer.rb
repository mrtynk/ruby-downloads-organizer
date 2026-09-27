# frozen_string_literal: true

require "fileutils"

class FileOrganizer
  attr_reader :courses, :file_types

  def initialize(
    downloads_dir: File.join(Dir.home, "Downloads"),
    destination_root: File.join(Dir.home, "Documents", "Dersler"),
    log_path: File.expand_path("../logs/usage.log", __dir__)
  )
    @downloads_dir = downloads_dir
    @destination_root = destination_root
    @log_path = log_path

    @courses = [
      "Ruby Programlama",
      "Yazılım Proje Yönetimi",
      "Bitirme Projesi",
      "Diğer"
    ]

    @file_types = [
      "Ödev",
      "Ders Notu",
      "Sunum",
      "Diğer"
    ]
  end

  def recent_downloads(limit: 10)
    return [] unless Dir.exist?(@downloads_dir)

    Dir.glob(File.join(@downloads_dir, "*"))
       .select { |path| File.file?(path) }
       .sort_by { |path| File.mtime(path) }
       .reverse
       .first(limit)
  end

  def generate_filename(original_path:, course:, file_type:, number: "")
    extension = File.extname(original_path).downcase
    parts = [normalize(course), normalize(file_type)]
    parts << normalize(number) unless number.to_s.strip.empty?
    "#{parts.join("_")}#{extension}"
  end

  def destination_for(course)
    File.join(@destination_root, normalize(course))
  end

  def move_file(source, destination_path)
    raise "Kaynak dosya bulunamadı." unless File.file?(source)

    destination_path = unique_destination(destination_path)
    FileUtils.mkdir_p(File.dirname(destination_path))
    FileUtils.mv(source, destination_path)

    log("#{File.basename(source)} -> #{destination_path}", "SUCCESS")
    destination_path
  end

  def log(action, result)
    FileUtils.mkdir_p(File.dirname(@log_path))
    File.open(@log_path, "a:utf-8") do |file|
      file.puts("#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} | #{action} | #{result}")
    end
  end

  private

  def normalize(text)
    transliterated = text.to_s
      .tr("çÇğĞıİöÖşŞüÜ", "cCgGiIoOsSuU")
      .strip
      .gsub(/\s+/, "_")
      .gsub(/[^A-Za-z0-9_-]/, "")
      .gsub(/_+/, "_")

    transliterated.empty? ? "Diger" : transliterated
  end

  def unique_destination(path)
    return path unless File.exist?(path)

    directory = File.dirname(path)
    extension = File.extname(path)
    base = File.basename(path, extension)
    counter = 2

    loop do
      candidate = File.join(directory, "#{base}_#{counter}#{extension}")
      return candidate unless File.exist?(candidate)
      counter += 1
    end
  end
end
