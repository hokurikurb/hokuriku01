#!/usr/bin/env ruby
require 'optparse'
require 'csv'
require 'erb'

options = {} # default option

if ARGV.size.zero?
  ARGV[0] = '-h'
end

ARGV.options do |opts|
  script_name = File.basename($0)
  opts.banner = "Usage: #{script_name} [options] talks.csv"

  opts.separator ""

  opts.on("-x", "--debug",
       "Debug mode.") { |v| options[:debug] = v }

  opts.separator ""

  opts.on("-h", "--help",
      "Show this help message.") { puts opts; exit }

  opts.parse!
end

file_path = ARGV[0]

# TimeTable HTML Generator
@version = DateTime.now.strftime("%Y%m%d%H%M%S")

@talks = []
File.open(file_path, "rb:UTF-8", undef: :replace) do |f|
  CSV.new(f, headers: true).each_with_index do |row, i|
    # csv
    talk_title = row[0]
    talk_abstract = row[1]
    talk_time = row[2]
    speaker_name = row[3]
    speaker_profile = row[5]
    speaker_image = row[7]
    speaker_sns_twitter = row[9]
    speaker_sns_github = row[10]

    # attr
    speaker_id = speaker_sns_github || speaker_sns_twitter
    speaker_image_url = "images/placeholder.svg" # default
    if speaker_image
      speaker_image_url = "images/speakers/#{speaker_image}"
    end

    if talk_time == "45分枠"
      talk_type = "KEYNOTE"
    elsif talk_time == "15分枠"
      talk_type = "SESSION"
    elsif talk_time == "LT 枠(5分)"
      talk_type = "LT"
    end

    talk_abstract_html = ERB::Util.html_escape(talk_abstract).gsub(/\r\n|\r|\n/, "<br />")
    speaker_profile_html = ERB::Util.html_escape(speaker_profile).gsub(/\r\n|\r|\n/, "<br />")

    speaker_sns_twitter_url = "https://x.com/#{speaker_sns_twitter}" if speaker_sns_twitter
    speaker_sns_github_url = "https://github.com/#{speaker_sns_github}" if speaker_sns_github

    talk = {
      talk_title:,
      talk_abstract:,
      talk_abstract_html:,
      talk_time:,
      talk_type:,
      speaker_name:,
      speaker_profile:,
      speaker_profile_html:,
      speaker_image_url:,
      speaker_sns_twitter:,
      speaker_sns_twitter_url:,
      speaker_sns_github:,
      speaker_sns_github_url:,
      speaker_id:,
    }

    @talks << talk
  end

  if options[:debug]
    pp @talks
  end
end

# Output: single page (timetable)
template_names = ['timetable', 'talks']
template_names.each do |template_name|
  template_file = File.join("./templates/", "#{template_name}.html.erb")
  File.open(template_file) do |template|
    # bind template
    html = ERB.new(template.read).result

    # output file
    output_file_name = "#{template_name}.html"
    output_file = File.join("./build/", output_file_name)
    File.write(output_file, html)
    print "Output: #{output_file}\n"
  end
end

# Output: talk pages
template_file_talk = File.join("./templates/", "talk.html.erb")
@talks.each_with_index do |talk, index|
  File.open(template_file_talk) do |template|
    @talk = talk

    # bind template
    html = ERB.new(template.read).result

    # output file
    output_file_name = "#{@talk[:speaker_id]}.html"
    output_file = File.join("./build/", "talks", output_file_name)
    unless Dir.exist?("./build/talks")
      Dir.mkdir("./build/talks")
    end
    File.write(output_file, html)
    print "Output(#{index + 1}): #{output_file}\n"
  end
end
