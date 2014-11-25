namespace :doorkeeper do
  namespace :tokens do
    desc 'Remove used tokens'
    task :cleanup => :environment do
      Doorkeeper::AccessToken
        .where('revoked_at is not null')
        .where('created_at < ?', 1.day.ago)
        .delete_all
    end
  end
end
