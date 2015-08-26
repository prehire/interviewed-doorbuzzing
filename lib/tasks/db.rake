namespace :db do
  desc 'Restore the DB from a production'
  task :dump do
    Bundler.with_clean_env { sh 'heroku pgbackups:capture --expire  --app doorbuzzing' }
    Bundler.with_clean_env { sh 'curl -o latest.dump `heroku pgbackups:url --app doorbuzzing`' }
    puts `pg_restore --verbose --clean --no-acl --no-owner -h localhost -d #{Rails.configuration.database_configuration['development']['database']} latest.dump`
    puts `rm latest.dump`
  end

  desc 'Seed from bookface JSON file'
  task seed_bookface: :environment do
    if path = ENV['FILE']
      parse_files([path])
    elsif Dir.glob("#{Rails.root}/tmp/*.json").size > 0
      parse_files(Dir.glob("#{Rails.root}/tmp/*.json"))
    else
      puts('Import file not found.')
      next
    end
  end

  def parse_files(paths)
    paths.each do |path|
      file = File.read(path)
      data = JSON.parse(file)
      companies = create_companies(data)
    end
  end

  def create_companies(data)
    data.each do |company_data|
      unless company = Company.find_by(hn_id: company_data['hnid'])
        company = Company.new(
          batch: Batch.find_by(name: company_data['batch']),
          bookface_id: company_data['id'],
          hn_id: company_data['hnid'],
          name: company_data['name'],
          status: nil,
          email: company_data['email'],
          website: company_data['website'],
          description: company_data['description']
        )
        if company.valid?
          company.save!
        else
          puts 'Data resulted in invalid company'
          puts company.errors.full_messages
          puts company_data
         end
      end

      create_users(company_data['users'], company) if company.persisted?
    end
  end

  def create_users(data, company)
    data.each do |user_data|
      unless user = User.find_by(hn_id: user_data['hnid'])
        user = User.new(
          bookface_id: user_data['id'],
          hn_id: user_data['hnid'],
          first_name: user_data['first_name'] || user_data['hnid'],
          last_name: user_data['last_name'],
          email: user_data['email'],
          mobile_phone: user_data['cell'],
          avatar_large: user_data['avatar_large']
        )
        if user.valid?
          user.save!
          CompanyUser.create!(
            user: user,
            company: company,
            status: 'active'
          )
        else
          puts 'Data resulted in invalid user'
          puts user.errors.full_messages
          puts user_data
         end
      end
    end
  end
end
