# frozen_string_literal: true

require 'minitest/autorun'

describe RangeList do # rubocop:disable Metrics/BlockLength
  describe 'add' do
    it 'fail' do
      rl = RangeList.new

      assert_raises(RangeList::InvalidArgsCntErr) do
        rl.add([20, 30, 40])
      end
    end

    it 'success' do
      rl = RangeList.new

      rl.add([1, 5])
      assert_equal('[1, 5)', rl.print)

      rl.add([10, 20])
      assert_equal('[1, 5) [10, 20)', rl.print)

      rl.add([20, 20])
      assert_equal('[1, 5) [10, 20)', rl.print)

      rl.add([20, 21])
      assert_equal('[1, 5) [10, 21)', rl.print)

      rl.add([2, 4])
      assert_equal('[1, 5) [10, 21)', rl.print)

      rl.add([3, 8])
      assert_equal('[1, 8) [10, 21)', rl.print)
    end
  end

  describe 'remove' do
    it 'fail' do
      rl = RangeList.new

      assert_raises(RangeList::InvalidArgsCntErr) do
        rl.remove([20, 30, 40])
      end
    end

    it 'success' do
      # NOTE: init data
      rl = RangeList.new

      rl.add([1, 5])
      rl.add([10, 20])
      rl.add([20, 20])
      rl.add([20, 21])
      rl.add([2, 4])
      rl.add([3, 8])
      assert_equal('[1, 8) [10, 21)', rl.print)

      rl.remove([10, 10])
      assert_equal('[1, 8) [10, 21)', rl.print)

      rl.remove([10, 11])
      assert_equal('[1, 8) [11, 21)', rl.print)

      rl.remove([15, 17])
      assert_equal('[1, 8) [11, 15) [17, 21)', rl.print)

      rl.remove([3, 19])
      assert_equal('[1, 3) [19, 21)', rl.print)
    end
  end

  it 'valid!' do
    rl = RangeList.new

    assert_raises(RangeList::InvalidArgsCntErr) do
      rl.send(:valid!, [20, 30, 40])
    end

    assert_raises(RangeList::InvalidArgsTypeErr) do
      rl.send(:valid!, [20, 'a'])
    end

    assert_raises(RangeList::InvalidArgsTypeErr) do
      rl.send(:valid!, %w[a b])
    end

    assert_raises(RangeList::InvalidArgsValueErr) do
      rl.send(:valid!, [10, 9])
    end

    assert_equal(true, rl.send(:valid!, [10, 10]))
    assert_equal(true, rl.send(:valid!, [10, 20]))
  end
end
