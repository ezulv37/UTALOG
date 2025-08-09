require 'rails_helper'

RSpec.describe KeyDisplayable do
  class DummyRecord
    include KeyDisplayable
    attr_accessor :key
  end

  let(:record) { DummyRecord.new }

  describe '#key_display' do
    it 'keyが指定されていない場合は「原曲」を返す' do
      record.key = nil
      expect(record.key_display).to eq('原曲')
    end

    it 'keyが0の場合は「原曲」を返す' do
      record.key = 0
      expect(record.key_display).to eq('原曲')
    end

    it 'keyが正の数の場合は「原曲+数字」を返す' do
      record.key = 1
      expect(record.key_display).to eq('原曲+1')
    end

    it 'keyが負の数の場合は「原曲-数字」を返す' do
      record.key = -1
      expect(record.key_display).to eq('原曲-1')
    end
  end
end
