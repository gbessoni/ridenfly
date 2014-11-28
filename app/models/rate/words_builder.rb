class Rate::WordsBuilder < Struct.new(:text)
  def words
    prepare(text.to_s.downcase)
  end

  STOP_WORDS = ['the']

  def prepare(text)
    text.gsub!(/[\.,\,,\;,\',\",\\,\/,\-]/, ' ')
    STOP_WORDS.each{ |s| text.gsub!(s, ' ') }
    text.squeeze(' ').split(' ').sort.join(' ')
  end
end
