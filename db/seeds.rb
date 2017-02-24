tag = Tag.create([{name: 'easy'}, {name: 'medium'}, {name: 'hard'}, {name: 'javascript'}, {name: 'ruby'}])

user = User.create(census_id: 66, role: 0, first_name: 'User', last_name: 'RippedTest', token: '1d7ff31ba472ed175978ac864cb9b74076208bb9b38798c42e14a0817f804a1b')

##### Ruby Exercises
## HelloWorld
hello_world = Exercise.new(name: 'Hello World', content: "gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'hamming' class HelloWorldTest < Minitest::Test
  def test_no_name
    assert_equal 'Hello, World!', HelloWorld.hello
  end

  def test_sample_name
    assert_equal 'Hello, Alice!', HelloWorld.hello('Alice')
  end

  def test_other_sample_name
    assert_equal 'Hello, Bob!', HelloWorld.hello('Bob')
  end
end" , description: 'Write a function that greets the user by name, or by saying "Hello, World!" if no name is given.', status: 0)
hello_world.tags = [tag.first, tag.last]
hello_world.save

## Hamming
hamming = Exercise.new(name: 'Hamming', content:"gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'hamming'

class HammingTest < Minitest::Test
  def test_identical_strands
    skip
    assert_equal 0, Hamming.compute('A', 'A')
  end

  def test_long_identical_strands
    skip
    assert_equal 0, Hamming.compute('GGACTGA', 'GGACTGA')
  end

  def test_complete_distance_in_single_nucleotide_strands
    skip
    assert_equal 1, Hamming.compute('A', 'G')
  end

  def test_complete_distance_in_small_strands
    skip
    assert_equal 2, Hamming.compute('AG', 'CT')
  end

  def test_small_distance_in_small_strands
    skip
    assert_equal 1, Hamming.compute('AT', 'CT')
  end

  def test_small_distance
    skip
    assert_equal 1, Hamming.compute('GGACG', 'GGTCG')
  end

  def test_small_distance_in_long_strands
    skip
    assert_equal 2, Hamming.compute('ACCAGGG', 'ACTATGG')
  end

  def test_non_unique_character_in_first_strand
    skip
    assert_equal 1, Hamming.compute('AGA', 'AGG')
  end

  def test_non_unique_character_in_second_strand
    skip
    assert_equal 1, Hamming.compute('AGG', 'AGA')
  end

  def test_same_nucleotides_in_different_positions
    skip
    assert_equal 2, Hamming.compute('TAG', 'GAT')
  end

  def test_large_distance
    skip
    assert_equal 4, Hamming.compute('GATACA', 'GCATAA')
  end

  def test_large_distance_in_off_by_one_strand
    skip
    assert_equal 9, Hamming.compute('GGACGGATTCTG', 'AGGACGGATTCT')
  end

  def test_empty_strands
    skip
    assert_equal 0, Hamming.compute('', '')
  end

  def test_disallow_first_strand_longer
    skip
    assert_raises(ArgumentError) { Hamming.compute('AATG', 'AAA') }
  end

  def test_disallow_second_strand_longer
    skip
    assert_raises(ArgumentError) { Hamming.compute('ATA', 'AGTG') }
  end
end", description: "Write a program that can calculate the Hamming difference between two DNA strands.

A mutation is simply a mistake that occurs during the creation or
copying of a nucleic acid, in particular DNA. Because nucleic acids are
vital to cellular functions, mutations tend to cause a ripple effect
throughout the cell. Although mutations are technically mistakes, a very
rare mutation may equip the cell with a beneficial attribute. In fact,
the macro effects of evolution are attributable by the accumulated
result of beneficial microscopic mutations over many generations.

The simplest and most common type of nucleic acid mutation is a point
mutation, which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands
taken from different genomes with a common ancestor, we get a measure of
the minimum number of point mutations that could have occurred on the
evolutionary path between the two strands.

This is called the 'Hamming distance'.

It is found by comparing two DNA strands and counting how many of the
nucleotides are different from their equivalent in the other string.

    GAGCCTACTAACGGGAT
    CATCGTAATGACGGCCT
    ^ ^ ^  ^ ^    ^^

The Hamming distance between these two DNA strands is 7.", status: 0)
hamming.tags = [tag.first, tag.last]
hamming.save

## Gigasecond
gigasecond = Exercise.new(name: 'Gigasecond', content: "require 'minitest/autorun'
require_relative 'gigasecond'

class GigasecondTest < Minitest::Test
  def test_2011_04_25
    result = Gigasecond.from(Time.utc(2011, 4, 25, 0, 0, 0))
    assert_equal Time.utc(2043, 1, 1, 1, 46, 40), result
  end

  def test_1977_06_13
    skip
    result = Gigasecond.from(Time.utc(1977, 6, 13, 0, 0, 0))
    assert_equal Time.utc(2009, 2, 19, 1, 46, 40), result
  end

  def test_1959_07_19
    skip
    result = Gigasecond.from(Time.utc(1959, 7, 19, 0, 0, 0))
    assert_equal Time.utc(1991, 3, 27, 1, 46, 40), result
  end

  def test_full_time_specified
    skip
    result = Gigasecond.from(Time.utc(2015, 1, 24, 22, 0, 0))
    assert_equal Time.utc(2046, 10, 2, 23, 46, 40), result
  end

  def test_full_time_with_day_roll_over
    skip
    result = Gigasecond.from(Time.utc(2015, 1, 24, 23, 59, 59))
    assert_equal Time.utc(2046, 10, 3, 1, 46, 39), result
  end

  # Test your 1Gs anniversary
  def test_with_your_birthday
    skip
  end
end" , description: "Write a program that calculates the moment when someone has lived for 10^9 seconds.

A gigasecond is 10^9 (1,000,000,000) seconds." , status: 0)
gigasecond.tags = [tag.first, tag.last]
gigasecond.save

## rna_transscription
rna_transscription = Exercise.new(name: "RNA Transcription", content: "gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'rna_transcription'

class ComplementTest < Minitest::Test
  def test_rna_complement_of_cytosine_is_guanine
    # skip
    assert_equal 'G', Complement.of_dna('C')
  end

  def test_rna_complement_of_guanine_is_cytosine
    skip
    assert_equal 'C', Complement.of_dna('G')
  end

  def test_rna_complement_of_thymine_is_adenine
    skip
    assert_equal 'A', Complement.of_dna('T')
  end

  def test_rna_complement_of_adenine_is_uracil
    skip
    assert_equal 'U', Complement.of_dna('A')
  end

  def test_rna_complement
    skip
    assert_equal 'UGCACCAGAAUU', Complement.of_dna('ACGTGGTCTTAA')
  end

  def test_dna_correctly_handles_invalid_input
    skip
    assert_equal '', Complement.of_dna('U')
  end

  def test_dna_correctly_handles_completely_invalid_input
    skip
    assert_equal '', Complement.of_dna('XXX')
  end

  def test_dna_correctly_handles_partially_invalid_input
    skip
    assert_equal '', Complement.of_dna('ACGTXXXCTTAA')
  end
end" , description: "Write a program that, given a DNA strand, returns its RNA complement (per RNA transcription).

Both DNA and RNA strands are a sequence of nucleotides.

The four nucleotides found in DNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and thymine (**T**).

The four nucleotides found in RNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and uracil (**U**).

Given a DNA strand, its transcribed RNA strand is formed by replacing
each nucleotide with its complement:

* `G` -> `C`
* `C` -> `G`
* `T` -> `A`
* `A` -> `U`", status: 0)
rna_transscription.tags = [tag.first, tag.last]
rna_transscription.save

## rainsdrops
raindrops = Exercise.new(name: "Raindrops", content: "gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'raindrops'

class RaindropsTest < Minitest::Test
  def test_1
    assert_equal '1', Raindrops.convert(1)
  end

  def test_3
    skip
    assert_equal 'Pling', Raindrops.convert(3)
  end

  def test_5
    skip
    assert_equal 'Plang', Raindrops.convert(5)
  end

  def test_7
    skip
    assert_equal 'Plong', Raindrops.convert(7)
  end

  def test_6
    skip
    assert_equal 'Pling', Raindrops.convert(6)
  end

  def test_8
    skip
    assert_equal '8', Raindrops.convert(8)
  end

  def test_9
    skip
    assert_equal 'Pling', Raindrops.convert(9)
  end

  def test_10
    skip
    assert_equal 'Plang', Raindrops.convert(10)
  end

  def test_14
    skip
    assert_equal 'Plong', Raindrops.convert(14)
  end

  def test_15
    skip
    assert_equal 'PlingPlang', Raindrops.convert(15)
  end

  def test_21
    skip
    assert_equal 'PlingPlong', Raindrops.convert(21)
  end

  def test_25
    skip
    assert_equal 'Plang', Raindrops.convert(25)
  end

  def test_27
    skip
    assert_equal 'Pling', Raindrops.convert(27)
  end

  def test_35
    skip
    assert_equal 'PlangPlong', Raindrops.convert(35)
  end

  def test_49
    skip
    assert_equal 'Plong', Raindrops.convert(49)
  end

  def test_52
    skip
    assert_equal '52', Raindrops.convert(52)
  end

  def test_105
    skip
    assert_equal 'PlingPlangPlong', Raindrops.convert(105)
  end

  def test_3125
    skip
    assert_equal 'Plang', Raindrops.convert(3125)
  end
end" , description: "Write a program that converts a number to a string, the contents of which depend on the number's factors.

- If the number has 3 as a factor, output 'Pling'.
- If the number has 5 as a factor, output 'Plang'.
- If the number has 7 as a factor, output 'Plong'.
- If the number does not have 3, 5, or 7 as a factor,
  just pass the number's digits straight through." , status: 0)
raindrops.tags = [tag.first, tag.last]
raindrops.save

## difference of squares
difference_of_squares = Exercise.new(name: "Difference of Squares" , content: "gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'difference_of_squares'

class DifferenceOfSquaresTest < Minitest::Test
  def test_square_of_sum_5
    assert_equal 225, Squares.new(5).square_of_sum
  end

  def test_square_of_sum_10
    skip
    assert_equal 3_025, Squares.new(10).square_of_sum
  end

  def test_square_of_sum_100
    skip
    assert_equal 25_502_500, Squares.new(100).square_of_sum
  end

  def test_sum_of_squares_5
    skip
    assert_equal 55, Squares.new(5).sum_of_squares
  end

  def test_sum_of_squares_10
    skip
    assert_equal 385, Squares.new(10).sum_of_squares
  end

  def test_sum_of_squares_100
    skip
    assert_equal 338_350, Squares.new(100).sum_of_squares
  end

  def test_difference_of_squares_0
    skip
    assert_equal 0, Squares.new(0).difference
  end

  def test_difference_of_squares_5
    skip
    assert_equal 170, Squares.new(5).difference
  end

  def test_difference_of_squares_10
    skip
    assert_equal 2_640, Squares.new(10).difference
  end

  def test_difference_of_squares_100
    skip
    assert_equal 25_164_150, Squares.new(100).difference
  end

  def test_consistent_difference
    skip
    squares = Squares.new(10)
    assert_equal squares.difference, squares.difference
  end
end", description: "Find the difference between the sum of the squares and the square of the sum of the first N natural numbers.

The square of the sum of the first ten natural numbers is
(1 + 2 + ... + 10)² = 55² = 3025.

The sum of the squares of the first ten natural numbers is
1² + 2² + ... + 10² = 385.

Hence the difference between the square of the sum of the first
ten natural numbers and the sum of the squares of the first ten
natural numbers is 3025 - 385 = 2640.", status: 0)
difference_of_squares.tags = [tag.first, tag.last]
difference_of_squares.save

### Javascript exercises
## Hello World
hello_world_js = Exercise.new(name: "Hello World", content: "
var HelloWorld = require('./hello-world');

describe('Hello World', function() {
  var helloWorld = new HelloWorld();

  it('says hello world with no name', function() {
    expect(helloWorld.hello('')).toEqual('Hello, World!');
  });

  xit('says hello to bob', function() {
    expect(helloWorld.hello('Bob')).toEqual('Hello, Bob!');
  });

  xit('says hello to sally', function() {
    expect(helloWorld.hello('Sally')).toEqual('Hello, Sally!');
  });
});" , description: "Write a function that greets the user by name, or by saying 'Hello, World!' if no name is given.", status: 0)
hello_world_js.tags = [tag.first, Tag.find_by(name: 'javascript')]
hello_world_js.save

## Hamming
hamming_js = Exercise.new(name: "Hamming" , content: "var Hamming = require('./hamming');

describe('Hamming', function () {
  var hamming = new Hamming();

  it('no difference between identical strands', function () {
    expect(hamming.compute('A', 'A')).toEqual(0);
  });

  xit('complete hamming distance for single nucleotide strand', function () {
    expect(hamming.compute('A','G')).toEqual(1);
  });

  xit('complete hamming distance for small strand', function () {
    expect(hamming.compute('AG','CT')).toEqual(2);
  });

  xit('small hamming distance', function () {
    expect(hamming.compute('AT','CT')).toEqual(1);
  });

  xit('small hamming distance in longer strand', function () {
    expect(hamming.compute('GGACG', 'GGTCG')).toEqual(1);
  });

  xit('large hamming distance', function () {
    expect(hamming.compute('GATACA', 'GCATAA')).toEqual(4);
  });

  xit('hamming distance in very long strand', function () {
    expect(hamming.compute('GGACGGATTCTG', 'AGGACGGATTCT')).toEqual(9);
  });

  xit('throws error when strands are not equal length', function() {
    expect(function() { hamming.compute('GGACGGATTCTG', 'AGGAC'); }).toThrow(
      new Error('DNA strands must be of equal length.')
    );
  });

});", description: "Write a program that can calculate the Hamming difference between two DNA strands.

A mutation is simply a mistake that occurs during the creation or
copying of a nucleic acid, in particular DNA. Because nucleic acids are
vital to cellular functions, mutations tend to cause a ripple effect
throughout the cell. Although mutations are technically mistakes, a very
rare mutation may equip the cell with a beneficial attribute. In fact,
the macro effects of evolution are attributable by the accumulated
result of beneficial microscopic mutations over many generations.

The simplest and most common type of nucleic acid mutation is a point
mutation, which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands
taken from different genomes with a common ancestor, we get a measure of
the minimum number of point mutations that could have occurred on the
evolutionary path between the two strands.

This is called the 'Hamming distance'.

It is found by comparing two DNA strands and counting how many of the
nucleotides are different from their equivalent in the other string.

    GAGCCTACTAACGGGAT
    CATCGTAATGACGGCCT
    ^ ^ ^  ^ ^    ^^

The Hamming distance between these two DNA strands is 7.", status: 0)
hamming_js.tags = [tag.first, Tag.find_by(name: 'javascript')]
hamming_js.save

## Gigasecond
gigasecond_js = Exercise.new(name: "Gigasecond", content: "var Gigasecond = require('./gigasecond');

describe('Gigasecond', function() {

  it('tells a gigasecond anniversary since midnight', function() {
    var gs = new Gigasecond(new Date(Date.UTC(2015, 8, 14)));
    var expectedDate = new Date(Date.UTC(2047, 4, 23, 1, 46, 40));
    expect(gs.date()).toEqual(expectedDate);
  });

  xit('tells the anniversary is next day when you are born at night', function() {
    var gs = new Gigasecond(new Date(Date.UTC(2015, 8, 14, 23, 59, 59)));
    var expectedDate = new Date(Date.UTC(2047, 4, 24, 1, 46, 39));
    expect(gs.date()).toEqual(expectedDate);
  });

  xit('even works before 1970 (beginning of Unix epoch)', function() {
    var gs = new Gigasecond(new Date(Date.UTC(1959, 6, 19, 5, 13, 45)));
    var expectedDate = new Date(Date.UTC(1991, 2, 27, 7, 0, 25));
    expect(gs.date()).toEqual(expectedDate);
  });

  xit('make sure calling 'date' doesn\'t mutate value', function() {
    var gs = new Gigasecond(new Date(Date.UTC(1959, 6, 19, 5, 13, 45)));
    var expectedDate = new Date(Date.UTC(1991, 2, 27, 7, 0, 25));
    gs.date();
    expect(gs.date()).toEqual(expectedDate);
  });
});", description: "Write a program that calculates the moment when someone has lived for 10^9 seconds.

A gigasecond is 10^9 (1,000,000,000) seconds.", status: 0)
gigasecond_js.tags = [tag.first, Tag.find_by(name: 'javascript')]
gigasecond_js.save

## RNA Transcription
rna_transcription_js = Exercise.new(name: "RNA Transcription", content: "var DnaTranscriber = require('./rna-transcription');
var dnaTranscriber = new DnaTranscriber();

describe('toRna()', function() {

  it('transcribes cytosine to guanine', function() {
    expect(dnaTranscriber.toRna('C')).toEqual('G');
  });

  xit('transcribes guanine to cytosine', function() {
    expect(dnaTranscriber.toRna('G')).toEqual('C');
  });

  xit('transcribes adenine to uracil', function() {
    expect(dnaTranscriber.toRna('A')).toEqual('U');
  });

  xit('transcribes thymine to adenine', function() {
    expect(dnaTranscriber.toRna('T')).toEqual('A');
  });

  xit('transcribes all dna nucleotides to their rna complements', function() {
    expect(dnaTranscriber.toRna('ACGTGGTCTTAA'))
        .toEqual('UGCACCAGAAUU');
  });

  xit('correctly handles completely invalid input', function () {
     expect(function () { dnaTranscriber.toRna('XXX') }).toThrow(
          new Error('Invalid input')
      );
  });

  xit('correctly handles partially invalid input', function () {
      expect(function () { dnaTranscriber.toRna('ACGTXXXCTTAA') }).toThrow(
          new Error('Invalid input')
      );
  });
});" , description: "Write a program that, given a DNA strand, returns its RNA complement (per RNA transcription).

Both DNA and RNA strands are a sequence of nucleotides.

The four nucleotides found in DNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and thymine (**T**).

The four nucleotides found in RNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and uracil (**U**).

Given a DNA strand, its transcribed RNA strand is formed by replacing
each nucleotide with its complement:

* `G` -> `C`
* `C` -> `G`
* `T` -> `A`
* `A` -> `U`", status: 0)
rna_transcription_js.tags = [tag.first, Tag.find_by(name: 'javascript')]
rna_transcription_js.save

## Raindrops
rainsdrops_js = Exercise.new(name: "Raindrops" , content: "var Raindrops = require('./raindrops');

describe('Raindrops', function() {
  var drops = new Raindrops();

  it('converts 1', function() {
    expect(drops.convert(1)).toEqual('1');
  });

  xit('converts 3', function() {
    expect(drops.convert(3)).toEqual('Pling');
  });

  xit('converts 5', function() {
    expect(drops.convert(5)).toEqual('Plang');
  });

  xit('converts 7', function() {
    expect(drops.convert(7)).toEqual('Plong');
  });

  xit('converts 6', function() {
    expect(drops.convert(6)).toEqual('Pling');
  });

  xit('converts 9', function() {
    expect(drops.convert(9)).toEqual('Pling');
  });

  xit('converts 10', function() {
    expect(drops.convert(10)).toEqual('Plang');
  });

  xit('converts 14', function() {
    expect(drops.convert(14)).toEqual('Plong');
  });

  xit('converts 15', function() {
    expect(drops.convert(15)).toEqual('PlingPlang');
  });

  xit('converts 21', function() {
    expect(drops.convert(21)).toEqual('PlingPlong');
  });

  xit('converts 25', function() {
    expect(drops.convert(25)).toEqual('Plang');
  });

  xit('converts 35', function() {
    expect(drops.convert(35)).toEqual('PlangPlong');
  });

  xit('converts 49', function() {
    expect(drops.convert(49)).toEqual('Plong');
  });

  xit('converts 52', function() {
    expect(drops.convert(52)).toEqual('52');
  });

  xit('converts 105', function() {
    expect(drops.convert(105)).toEqual('PlingPlangPlong');
  });

  xit('converts 12121', function() {
    expect(drops.convert(12121)).toEqual('12121');
  });

});" , description: "Write a program that converts a number to a string, the contents of which depend on the number's factors.

- If the number has 3 as a factor, output 'Pling'.
- If the number has 5 as a factor, output 'Plang'.
- If the number has 7 as a factor, output 'Plong'.
- If the number does not have 3, 5, or 7 as a factor,
  just pass the number's digits straight through.", status: 0)
rainsdrops_js.tags = [tag.first, Tag.find_by(name: 'javascript')]
rainsdrops_js.save

## difference of squares
difference_of_squares_js = Exercise.new(name: "Differce of Sqaures", content: "var Squares = require('./difference-of-squares');

describe('Squares', function () {

  describe('up to 5', function () {
    var squares = new Squares(5);

    it('gets the square of sums', function () {
      expect(squares.squareOfSums).toBe(225);
    });

    xit('gets the sum of squares', function () {
      expect(squares.sumOfSquares).toBe(55);
    });

    xit('gets the difference', function () {
      expect(squares.difference).toBe(170);
    });

  });

  describe('up to 10', function () {
    var squares = new Squares(10);

    xit('gets the square of sums', function () {
      expect(squares.squareOfSums).toBe(3025);
    });

    xit('gets the sum of squares', function () {
      expect(squares.sumOfSquares).toBe(385);
    });

    xit('gets the difference', function () {
      expect(squares.difference).toBe(2640);
    });

  });

  describe('up to 100', function () {
    var squares = new Squares(100);

    xit('gets the square of sums', function () {
      expect(squares.squareOfSums).toBe(25502500);
    });

    xit('gets the sum of squares', function () {
      expect(squares.sumOfSquares).toBe(338350);
    });

    xit('gets the difference', function () {
      expect(squares.difference).toBe(25164150);
    });

  });

});", description: "Find the difference between the sum of the squares and the square of the sum of the first N natural numbers.

The square of the sum of the first ten natural numbers is
(1 + 2 + ... + 10)² = 55² = 3025.

The sum of the squares of the first ten natural numbers is
1² + 2² + ... + 10² = 385.

Hence the difference between the square of the sum of the first
ten natural numbers and the sum of the squares of the first ten
natural numbers is 3025 - 385 = 2640.", status: 0)
difference_of_squares_js.tags = [tag.first, Tag.find_by(name: 'javascript')]
difference_of_squares_js.save
