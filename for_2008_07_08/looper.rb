#!/usr/bin/env ruby
# looper.rb

class Looper

  def initialize(*args)
    @items = args
  end

  def detect(&block)
    select(&block)[0]
  end

  def select
    @items.inject([]) do |m,i|
      m << i if yield(i); m
    end
  end

  def reject
    @items.inject([]) do |m,i|
      m << i unless yield(i); m
    end
  end

  def collect
    @items.inject([]) do |m,i|
      m << yield(i); m
    end
  end

end
