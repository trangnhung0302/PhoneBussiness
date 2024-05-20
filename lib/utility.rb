class Utility
  class << self
    # rubocop:disable Metrics/AbcSize
    def make_random_string(first, last)
      ignore = %w[I O V W]
      o = [('A'..'Z')].map(&:to_a).flatten
      o.reject! { |c| ignore.include?(c) }
      s = [('1'..'9')].map(&:to_a).flatten
      f = Range.new(0, first).map { o[rand(o.length)] }.join
      l = Range.new(0, last).map { s[rand(s.length)] }.join
      (f + l)
    end
  end
end
