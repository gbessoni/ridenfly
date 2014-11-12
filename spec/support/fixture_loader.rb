module FixtureLoader
  def load_fixture(filename)
    File.open(File.join(
      File.expand_path('../fixtures', __FILE__),
      filename
    )) { |f| f.read }
  end
end
