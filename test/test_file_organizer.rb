# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"
require "fileutils"
require_relative "../lib/file_organizer"

class FileOrganizerTest < Minitest::Test
  def setup
    @tmp = Dir.mktmpdir
    @downloads = File.join(@tmp, "Downloads")
    @destination = File.join(@tmp, "Dersler")
    @log = File.join(@tmp, "usage.log")
    FileUtils.mkdir_p(@downloads)

    @organizer = FileOrganizer.new(
      downloads_dir: @downloads,
      destination_root: @destination,
      log_path: @log
    )
  end

  def teardown
    FileUtils.remove_entry(@tmp)
  end

  def test_generate_filename
    original = File.join(@downloads, "odev1.pdf")

    result = @organizer.generate_filename(
      original_path: original,
      course: "Ruby Programlama",
      file_type: "Ödev",
      number: "1"
    )

    assert_equal "Ruby_Programlama_Odev_1.pdf", result
  end

  def test_move_file
    source = File.join(@downloads, "odev.pdf")
    File.write(source, "test")

    destination = File.join(
      @organizer.destination_for("Ruby Programlama"),
      "Ruby_Programlama_Odev.pdf"
    )

    final_path = @organizer.move_file(source, destination)

    refute File.exist?(source)
    assert File.exist?(final_path)
    assert_includes File.read(@log), "SUCCESS"
  end

  def test_recent_downloads_returns_newest_first
    old_file = File.join(@downloads, "old.txt")
    new_file = File.join(@downloads, "new.txt")

    File.write(old_file, "old")
    File.write(new_file, "new")

    old_time = Time.now - 60
    new_time = Time.now

    File.utime(old_time, old_time, old_file)
    File.utime(new_time, new_time, new_file)

    result = @organizer.recent_downloads(limit: 2)

    assert_equal new_file, result.first
  end
end
