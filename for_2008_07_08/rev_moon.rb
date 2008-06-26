#!/usr/bin/env ruby
# rev_moon.rb

class ReassignmentError < StandardError
end

=begin rdoc
Implement Unification (http://en.wikipedia.org/wiki/Unification), 
hence the punny name.
=end
class RevMoon

  @@congregation = {}

  def clear!
    @@congregation = {}
    self
  end

  def unify(pattern, data)
    return attempt_merge!( { pattern => data } ) unless pattern.respond_to?(:each_index)
    
    match_buffer = {}
    pattern.each_index do |idx|
      p_item, d_item = pattern[idx], data[idx]
      next   if p_item == d_item
      return if unmatchable?(p_item, d_item, match_buffer)
      match_buffer[p_item] = d_item
    end

    attempt_merge!(match_buffer)
  end

  private

  def attempt_merge!(data)
    raise ReassignmentError if data.keys.any? { |k| unmatchable?(k, data[k]) }
    @@congregation.merge!(data)
  end

  def differing_literal_atoms?(s_item, d_item)
    return false if s_item.is_a?(Symbol)
    s_item != d_item
  end

  def unmatchable?(s_item, d_item, matches=@@congregation)
    return true  if differing_literal_atoms?(s_item, d_item)
    
    # if previous match isn't present, it's free to assign ('matchable')
    return false unless previous = matches[s_item]
    
    # couldn't match because of split values for a single symbol
    previous != d_item
  end

end
