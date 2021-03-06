require 'spec_helper'
require 'loc_scraper'

describe LocScraper::Record do

  before(:all) do
    @isbn = '9781602530454'
    @record = LocScraper::Record.new(@isbn)
  end

  describe '.get' do
    it 'creates an instance of LocScraper::Record class' do
      expect(@record).to be_instance_of LocScraper::Record
    end

    it 'removes dashes from ISBN' do
      record = LocScraper::Record.new('978-160253-0454')
      expect(@record.isbn).to eq '9781602530454'
    end

    it 'coerces ISBN from number to string' do
      record = LocScraper::Record.new(9781602530454)
      expect(@record.isbn).to eq '9781602530454'
    end

    it 'raises error when ISBN not found' do
      expect(lambda { LocScraper::Record.new('9789999999999') }).to raise_exception ArgumentError
    end

    it 'raises error when ISBN is blank' do
      expect(lambda { LocScraper::Record.new('') }).to raise_exception ArgumentError
    end
  end

  describe '#search_by_label' do
    it 'returns nil when label not found' do
      expect(@record.send(:search_by_label, 'UNKNOWN:')).to eq nil
    end

    it 'raises error when label not found' do
      expect(lambda { @record.send(:search_by_label, 'UNKNOWN:', allow_nil: false) }).to raise_exception(StandardError, 'Label not found: UNKNOWN:')
    end
  end

  describe '#main_title' do
    it 'returns the main title of the record' do
      expect(@record.main_title).to eq 'Abraham Lincoln : our sixteenth president / by Sarah Hansen.'
    end
  end

  describe '#dewey' do
    it 'returns the dewey of the record' do
      expect(@record.dewey).to eq '973.7092 B'
    end
  end

  describe '#lccn' do
    it 'returns the lccn of the record' do
      expect(@record.lccn).to eq '2008001164'
    end
  end

  describe '#lcc' do
    it 'returns the lcc of the record' do
      expect(@record.lcc).to eq 'E457.905 .H285 2009'
    end
  end

  describe '#summary' do
    it 'returns nil when record does not have summary' do
      expect(@record.summary).to eq nil
    end

    it 'returns the summary of the record' do
      record = LocScraper::Record.new('9781585368099')
      expect(record.summary).to eq '"A beginning reader book containing two stories featuring Frog and his friends, where the friends mistake a train for a terrible dragon and Frog rescues a baby possum after it falls into a river"-- Provided by publisher.'
    end
  end

  describe '#to_json' do
    it 'returns the json format of the record' do
      @record.to_json
    end
  end

end
