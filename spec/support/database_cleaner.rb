RSpec.configure do |config|
  # This says that before the entire test suite runs, clear the test database out completely. 
  # This gets rid of any garbage left over from interrupted or poorly-written tests—a common 
  # source of surprising test behavior.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # This part sets the default database cleaning strategy to be transactions. 
  # Transactions are very fast, and for all the tests where they do work—that is, 
  # any test where the entire test runs in the RSpec process—they are preferable.
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # This line only runs before examples which have been flagged :js => true.
  # By default, these are the only tests for which Capybara fires up a test
  # server process and drives an actual browser window via the Selenium backend.
  # For these types of tests, transactions won’t work, so this code overrides the
  # setting and chooses the “truncation” strategy instead.
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  # These lines hook up database_cleaner around the beginning and end of each test, 
  # telling it to execute whatever cleanup strategy we selected beforehand.
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  # config.before(:each, type: :feature) do
  #   # :rack_test driver's Rack app under test shares database connection
  #   # with the specs, so we can use transaction strategy for speed.
  #   driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

  #   if driver_shares_db_connection_with_specs
  #     DatabaseCleaner.strategy = :transaction
  #   else
  #     # Non-:rack_test driver is probably a driver for a JavaScript browser
  #     # with a Rack app under test that does *not* share a database 
  #     # connection with the specs, so we must use truncation strategy.
  #     DatabaseCleaner.strategy = :truncation
  #   end
  # end
end
