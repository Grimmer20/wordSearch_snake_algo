require_relative '../word_search'

describe 'straight_line_include?' do
   let(:puzzle) {
    [
      ["a", "k", "f", "o", "x", "e", "s"],
      ["s", "o", "a", "w", "a", "h", "p"],
      ["i", "t", "c", "k", "e", "t", "n"],
      ["o", "t", "s", "d", "h", "o", "h"],
      ["s", "e", "x", "g", "s", "t", "a"],
      ["u", "r", "p", "i", "w", "e", "u"],
      ["z", "s", "b", "n", "u", "i", "r"]
    ]
   }

  it 'finds words that exist in the array' do
    expect(straight_line_include?('otter',puzzle)).to be true
    expect(straight_line_include?('foxes',puzzle)).to be true
  end

  it 'finds words that are diagonal' do
    expect(straight_line_include?('bison',puzzle)).to be true
  end

  it 'does not finds words that do not exist' do
    expect(straight_line_include?('bobolink',puzzle)).to be false
    expect(straight_line_include?('rabbit',puzzle)).to be false
  end

end

describe 'snaking_include?' do
    let(:puzzle) {
    [
      ["a", "k", "f", "o", "x", "e", "s"],
      ["s", "o", "a", "w", "a", "h", "p"],
      ["i", "t", "c", "k", "e", "t", "n"],
      ["o", "t", "s", "d", "h", "o", "h"],
      ["s", "e", "x", "g", "s", "t", "a"],
      ["u", "r", "p", "i", "w", "e", "u"],
      ["z", "s", "b", "n", "u", "i", "r"]
    ]
   }

  it 'finds words that exist in the array' do
    expect(snaking_include?('otter',puzzle)).to be_truthy
    expect(snaking_include?('foxes',puzzle)).to be_truthy
  end

  it 'finds words that are diagonal' do
    expect(snaking_include?('bison',puzzle)).to be_truthy
  end

  it 'does not finds words that do not exist' do
    expect(snaking_include?('bobolink',puzzle)).to be false
    expect(snaking_include?('rabbit',puzzle)).to be false
  end

  it 'finds words that are snaked' do
    expect(snaking_include?('seat',puzzle)).to be_truthy
    expect(snaking_include?('serpig',puzzle)).to be_truthy
  end
end
