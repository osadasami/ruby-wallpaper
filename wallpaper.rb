#!/usr/bin/env ruby

require 'ferrum'
require 'open-uri'
require 'thor'

class Unsplash < Thor
  class_option :size, desc: 'Specify image size', aliases: [:s]
  class_option :headless, type: :boolean, default: true, aliases: [:h], desc: 'Hide browser window'

  desc "random", "Get random image"

  def random
    init

    if options[:size]
      @br.go_to("https://source.unsplash.com/random/#{options[:size]}")
    else
      @br.go_to("https://source.unsplash.com/random")
    end

    save
  end

  desc "user NAME", "Get random image from user NAME"

  option :likes, type: :boolean, desc: "Get user's likes", aliases: [:l]

  def user(name)
    init

    @br.go_to("https://source.unsplash.com/user/#{name}") unless options[:likes] && options[:size]
    @br.go_to("https://source.unsplash.com/user/#{name}/#{options[:size]}") if options[:size] && !options[:likes]
    @br.go_to("https://source.unsplash.com/user/#{name}/likes") if options[:likes] && !options[:size]
    @br.go_to("https://source.unsplash.com/user/#{name}/likes/#{options[:size]}") if options[:likes] && options[:size]

    save
  end

  desc "q SEARCH1,SEARCH2", "Get random image from search"

  def q(query)
    init

    @br.go_to("https://source.unsplash.com/1920x1080/?#{query}") unless options[:size]
    @br.go_to("https://source.unsplash.com/#{options[:size]}/?#{query}") if options[:size]

    save
  end

  private

  def init
    @br = Ferrum::Browser.new(headless: options[:headless])
  end

  def osascript(script)
    system 'osascript', *script.split(/\n/).map { |line| ['-e', line] }.flatten
  end

  def save
    src = @br.css('img')[0].attribute('src')
    File.write("wallpaper.png", URI.open(src).read)

    osascript <<-END
      tell application "System Events" to set picture of every desktop to "#{Dir.pwd}/wallpaper.png"
    END

    `killall Dock`
  end
end

Unsplash.start(ARGV)