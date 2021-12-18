# frozen_string_literal: true

# RangeList: integer range store
class RangeList
  InvalidArgsCntErr = Class.new(StandardError)
  InvalidArgsTypeErr = Class.new(StandardError)
  InvalidArgsValueErr = Class.new(StandardError)

  attr_accessor :store

  def initialize
    @store = {}
  end

  def add(range)
    valid!(range)

    f, t = range
    (f...t).each do |i|
      store[i] = true
    end
  end

  def remove(range)
    valid!(range)

    f, t = range
    (f...t).each do |i|
      store.delete(i)
    end
  end

  def print
    pairs = []

    store.each do |k, _v|
      next if store[k - 1]

      cur = k

      cur += 1 while store[cur + 1]

      pairs.push([k, cur + 1])
    end

    pairs.map do |f, t|
      "[#{f}, #{t})"
    end.join(' ')
  end

  private

  def valid!(range)
    raise InvalidArgsCntErr if range.size != 2

    raise InvalidArgsTypeErr unless range.all? { |i| i.is_a?(Integer) }

    raise InvalidArgsValueErr unless range[1] >= range[0]

    true
  end
end
