class Rate::WordsBuilder < Struct.new(:text)
  def words
    prepare(text.to_s.downcase)
  end

  STOP_WORDS = ['the']

  def prepare(t)
    t = t.gsub(/[\.,\,,\;,\',\",\\,\/,\-,\&]/, ' ')
    STOP_WORDS.each{ |s| t.gsub!(s, ' ') }
    t.squeeze(' ').split(' ').uniq.sort.join(' ')
  end
end
