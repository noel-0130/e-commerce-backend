namespace :db do
  desc "Run database seeds only once"
  task seed_once: :environment do
    seed_name = "initial_seed"

    if SeedRun.exists?(seed_name: seed_name)
      puts "Seeds already completed. Skipping."
    else
      Rake::Task["db:seed"].invoke

      SeedRun.create!(seed_name: seed_name)

      puts "Seeds completed successfully."
    end
  end
end