namespace :scheduling_job_test do
  desc "TODO"
  task make_business: :environment do
    
    Bussiness.create(bs_name: "** Scheduling 테스트 **", address: "테스트", phone: "테스트")
    
  end

end
