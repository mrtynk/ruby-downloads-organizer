# frozen_string_literal: true

require_relative "lib/file_organizer"

organizer = FileOrganizer.new

begin
  files = organizer.recent_downloads(limit: 10)

  if files.empty?
    puts "Downloads klasöründe düzenlenecek dosya bulunamadı."
    organizer.log("Downloads tarandı", "NO_FILES")
    exit
  end

  puts "\nSon indirilen dosyalar:\n\n"
  files.each_with_index do |path, index|
    puts "#{index + 1}) #{File.basename(path)}"
  end

  print "\nDosya seç (iptal için 0): "
  choice = gets.to_i

  if choice == 0
    organizer.log("Kullanıcı işlemden vazgeçti", "CANCELLED")
    puts "İşlem iptal edildi."
    exit
  end

  unless choice.between?(1, files.length)
    organizer.log("Geçersiz dosya seçimi: #{choice}", "ERROR")
    abort "Geçersiz seçim."
  end

  source = files[choice - 1]

  puts "\nHangi kategori?"
  organizer.courses.each_with_index { |course, index| puts "#{index + 1}) #{course}" }

  print "\nKategori seç: "
  course_choice = gets.to_i

  unless course_choice.between?(1, organizer.courses.length)
    organizer.log("Geçersiz kategori seçimi: #{course_choice}", "ERROR")
    abort "Geçersiz seçim."
  end

  course = organizer.courses[course_choice - 1]

  if course == "Diğer"
    print "Kategori adı: "
    course = gets.chomp.strip
  end

  puts "\nDosya türü:"
  organizer.file_types.each_with_index { |type, index| puts "#{index + 1}) #{type}" }

  print "\nDosya türü seç: "
  type_choice = gets.to_i

  unless type_choice.between?(1, organizer.file_types.length)
    organizer.log("Geçersiz dosya türü seçimi: #{type_choice}", "ERROR")
    abort "Geçersiz seçim."
  end

  file_type = organizer.file_types[type_choice - 1]

  if file_type == "Diğer"
    print "Dosya türü adı: "
    file_type = gets.chomp.strip
  end

  print "Numara / hafta (yoksa Enter): "
  number = gets.chomp.strip

  new_name = organizer.generate_filename(
    original_path: source,
    course: course,
    file_type: file_type,
    number: number
  )

  destination_dir = organizer.destination_for(course)
  destination_path = File.join(destination_dir, new_name)

  puts "\nÖnerilen isim: #{new_name}"
  puts "Taşınacak klasör: #{destination_dir}"
  print "\nOnaylıyor musun? [E/H]: "

  answer = gets.chomp.strip.downcase

  unless %w[e evet y yes].include?(answer)
    organizer.log("#{File.basename(source)} için taşıma onayı verilmedi", "CANCELLED")
    puts "İşlem iptal edildi."
    exit
  end

  final_path = organizer.move_file(source, destination_path)

  puts "\n✓ Dosya düzenlendi:"
  puts "#{source}"
  puts "-> #{final_path}"

rescue StandardError => e
  organizer.log("#{e.class}: #{e.message}", "ERROR")
  warn "\nHata: #{e.message}"
end
