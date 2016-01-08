require 'spec_helper'

RSpec.describe Denv do
  describe Denv::Parser do
    let(:parser) { described_class.new(StringIO.new(content), filename) }
    let(:filename) { '/config/.env' }

    describe '#parse' do
      let(:content) { "x=123\ny=345\n" }

      it 'parses' do
        expect(parser.parse).to eq('x' => '123', 'y' => '345')
      end

      context 'with comment' do
        let(:content) { "x=123\n# comment\ny=345\n" }

        it 'ignores comment' do
          expect(parser.parse).to eq('x' => '123', 'y' => '345')
        end
      end

      context 'with commentwith white space' do
        let(:content) { "x=123\n  # comment\ny=345\n" }

        it 'ignores comment' do
          expect(parser.parse).to eq('x' => '123', 'y' => '345')
        end
      end

      context 'with comment line which does not appear first position' do
        let(:content) { "x=123\ny=345# comment\n" }

        it 'does not ignore comment and includes comment in value' do
          expect(parser.parse).to eq('x' => '123', 'y' => '345# comment')
        end
      end

      context 'with invalid format line' do
        let(:content) { "x=123\ny\n" }

        it 'raises InvalidFormatError' do
          expect { parser.parse }.to raise_error(Denv::InvalidFormatError, /#{filename}:2/)
        end
      end

      context 'with key name including whitespaces' do
        let(:content) { "xx x=123\ny=345\n" }

        it 'raises InvalidKeyNameError' do
          expect { parser.parse }.to raise_error(Denv::InvalidKeyNameError, /#{filename}:1/)
        end
      end

      context 'with multiple `=` characters' do
        let(:content) { "x=12=3\ny=345\n" }

        it 'seprates by first `=` character and treats other `=` characters as value' do
          expect(parser.parse).to eq('x' => '12=3', 'y' => '345')
        end
      end

      context 'with value including whitespace' do
        let(:content) { "x=a text with whitespaces\ny=345\n" }

        it 'treats whitespaces as value' do
          expect(parser.parse).to eq('x' => 'a text with whitespaces', 'y' => '345')
        end
      end

      context 'with single quoted value' do
        let(:content) { "x='a text with single quotes'\ny='345'\n" }

        it 'does not ignore single quotes' do
          expect(parser.parse).to eq('x' => "'a text with single quotes'", 'y' => "'345'")
        end
      end

      context 'with double quoted value' do
        let(:content) { %!x="a text with double quotes"\ny="345"\n! }

        it 'does not ignore double quotes' do
          expect(parser.parse).to eq('x' => '"a text with double quotes"', 'y' => '"345"')
        end
      end
    end
  end
end
