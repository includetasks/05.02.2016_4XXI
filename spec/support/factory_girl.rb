RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  # Configuration of FactoryGirl linting
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
