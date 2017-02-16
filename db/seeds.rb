tag = Tag.create([{name: 'easy'}, {name: 'medium'}, {name: 'hard'}, {name: 'ruby'}, {name: 'javascript'}])

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
