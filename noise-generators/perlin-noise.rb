# Reference: https://adrianb.io/2014/08/09/perlinnoise.html
require 'matrix'

module NoiseGenerators
  class PerlinNoise
    def initialize repeat = -1, seed = 0
      @repeat = repeat

      @p = []
      @permutations = []

      256.times do |time|
        @permutations.push time
      end

      @permutations.sort_by! do |item|
        Random.new(seed + item).rand()
      end

      512.times { |time| @p.push @permutations[time % 256] }
    end

    public

      def octave_perlin x, y, octaves, persistence
        total = 0
        frequency = 1
        amplitude = 1
        maxValue = 0

        octaves.times do |octave|
          total = perlin(x * frequency, y * frequency) * amplitude

          maxValue += amplitude
          amplitude *= persistence
          frequency *= 2
        end

        total / maxValue
      end

    private

      def perlin x, y
        if @repeat > 0
          x = x % @repeat
          y = y % @repeat
        end
      
        xi = x.to_i % 256
        yi = y.to_i % 256

        aaa = @p[@p[xi] + yi ]
        aba = @p[@p[xi] + increment(yi)]

        baa = @p[@p[increment(xi)] + yi]
        bba = @p[@p[increment(xi)] + increment(yi)]

        calculate_dot_product_of_gradient([aaa, aba], [baa, bba]) % 256
      end

      def increment num
        num += 1
        num %= @repeat if @repeat > 0
        num;
      end

      def calculate_dot_product_of_gradient arr1, arr2
        a = Vector.elements(arr1)
        b = Vector.elements(arr2)

        a.inner_product(b)
      end

      def fade t
        t * t * t * (t * (t * 6 - 15) + 10)
      end

      def lerp a, b, x
        a + x * (b - a)
      end
  end
end